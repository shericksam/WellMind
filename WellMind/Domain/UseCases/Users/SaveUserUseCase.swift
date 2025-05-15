//
//  SaveUserUseCase.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation

struct SaveUserUseCase {
    let repository: UserRepository

    func execute(user: User) async throws {
        try await repository.saveUser(user)
    }
}
