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

    init(getUserUseCase: GetUserUseCase) {
        self.getUserUseCase = getUserUseCase
    }
    
    func loadUser() async {
        isLoading = true
        do {
            user = try await getUserUseCase.execute()
        } catch {
            print("Failed to fetch users: \(error)")
        }
        isLoading = false
    }

}
