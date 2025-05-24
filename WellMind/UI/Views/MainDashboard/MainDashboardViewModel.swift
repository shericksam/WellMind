//
//  MainDashboardViewModel.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 14/05/25.
//

import Foundation

@MainActor
final class MainDashboardViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var isLoading: Bool = false
    private let getUserUseCase: GetUserUseCase
    let healthManager: HealthManager

    init(getUserUseCase: GetUserUseCase, healthManager: HealthManager) {
        self.getUserUseCase = getUserUseCase
        self.healthManager = healthManager
    }
    
    func loadUser() async {
        isLoading = true
            Task { @MainActor in
                do {
                    user = try await getUserUseCase.execute()
                    print("user--->", user?.name ?? "no name")
                    if user == nil {
                        UserDefaults.standard.set(false, forKey: "hasSeenWelcome") 
                    }
                } catch {
                    print("Failed to fetch user: \(error)")
                }
                self.isLoading = false
            }
    }

    func healthManagerRequestAuthorization() {
        healthManager.requestAuthorization()
    }
}
