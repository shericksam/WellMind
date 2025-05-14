//
//  WelcomeViewModel.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation
import SwiftUI

enum WelcomeViewSection: CaseIterable, SectionChangable {
    typealias Section = Self
    
    case form
    case goals
}

@MainActor
final class WelcomeViewModel: ObservableObject {
    @Published var newUser: User = User()
    @Published var selectedSegment: WelcomeViewSection = .form
    
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
}
