//
//  WelcomeViewModel.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Combine
import Foundation
import SwiftUI

enum WelcomeViewSection: CaseIterable, SectionChangable {
    typealias Section = Self
    
    case form
    case goals
    case onSave
}

@MainActor
final class WelcomeViewModel: ObservableObject {
    // MARK: - Inputs
    @Published var newUser: User = User()
    @Published var selectedSegment: WelcomeViewSection = .form
    
    // MARK: - Validation Outputs
    @Published private(set) var isFormValid: Bool = false
    @Published private(set) var isGoalsValid: Bool = false
    @Published private(set) var isAllValid: Bool = false
    @Published var formSubmitted: Bool = false
    
    @Published var nameError: String? = nil
    @Published var birthdayError: String? = nil
    @Published var genderError: String? = nil
    @Published var goalsError: String? = nil
    // MARK: - Combine
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupValidation()
    }
    
    private func setupValidation() {
        Publishers.CombineLatest3(
            $newUser.map(\.name),
            $newUser.map(\.birthday),
            $newUser.map(\.gender)
        )
        .map { [weak self] name, birthday, gender in
            guard let self, formSubmitted else { return false }
            let isNameValid = !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            nameError = isNameValid ? nil : "user_name_required_error".localized
            let isBirthdayValid = birthday < Calendar.current.date(byAdding: .year, value: -10, to: .now)!
            birthdayError = isBirthdayValid ? nil : "user_minimum_age_error".localized
            let isGenderSelected = gender != .unspecified
            genderError = isGenderSelected ? nil : "user_gender_error".localized
            return isNameValid && isBirthdayValid && isGenderSelected
        }
        .assign(to: &$isFormValid)
        
        $newUser.map(\.goals)
            .map { [weak self] goals in
                guard let self, formSubmitted else { return false }
                goalsError = goals.isEmpty ? "user_goals_error".localized : nil
                return !goals.isEmpty
            }
            .assign(to: &$isGoalsValid)
        
        Publishers.CombineLatest($isFormValid, $isGoalsValid)
            .map { $0 && $1 }
            .assign(to: &$isAllValid)
    }
    
    func validateAllFields() -> Bool {
        var isValid = true

        if newUser.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            nameError = "user_name_required_error".localized
            isValid = false
        } else {
            nameError = nil
        }

        let minAgeDate = Calendar.current.date(byAdding: .year, value: -10, to: .now)!
        if newUser.birthday >= minAgeDate {
            birthdayError = "user_minimum_age_error".localized
            isValid = false
        } else {
            birthdayError = nil
        }

        if newUser.gender == .unspecified {
            genderError = "user_gender_error".localized
            isValid = false
        } else {
            genderError = nil
        }

        if newUser.goals.isEmpty {
            goalsError = "user_goals_error".localized
            isValid = false
        } else {
            goalsError = nil
        }

        formSubmitted = true
        return isValid
    }

    func ontapGoal(_ goal: WellnessGoal) {
        if newUser.goals.contains(goal) {
            newUser.goals.removeAll { actualGoal in
                actualGoal == goal
            }
        } else {
            newUser.goals.append(goal)
        }
    }
    
    func isGoalSelected(_ goal: WellnessGoal) -> Bool {
        newUser.goals.contains(goal)
    }

    func changeSection(_ option: ControlSection) {
        selectedSegment.changeSection(option)
    }
    
    func startSaving() {
        self.selectedSegment = .onSave

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
            UserDefaults.standard.set(true, forKey: "hasSeenWelcome")
        }
    }

}
