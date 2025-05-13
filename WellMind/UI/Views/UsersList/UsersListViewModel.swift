//
//  UsersListViewModel.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation
import SwiftData

@MainActor
final class UsersListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false

    private let userUseCases: UserUseCases

    init(userUseCases: UserUseCases) {
        self.userUseCases = userUseCases
    }

    func loadUsers() async {
        isLoading = true
        do {
            users = try await userUseCases.getUsers.execute()
        } catch {
            print("Failed to fetch users: \(error)")
        }
        isLoading = false
    }

    func addUser(name: String, email: String) async {
        let newUser = User(id: Int.random(in: 1000...9999), name: name, email: email)
        do {
            try await userUseCases.addUsers.execute(users: [newUser])
            await loadUsers()
        } catch {
            print("Failed to add user: \(error)")
        }
    }

    func deleteUser(at offsets: IndexSet) async {
        do {
            for index in offsets {
                let user = users[index]
                try await userUseCases.deleteUser.execute(id: user.id)
            }
            await loadUsers()
        } catch {
            print("Failed to delete user: \(error)")
        }
    }
}
