//
//  AddUsersUseCase.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation

struct AddUsersUseCase {
    let repository: UserRepository

    func execute(users: [User]) async throws {
        try await repository.addUsers(users: users)
    }
}
