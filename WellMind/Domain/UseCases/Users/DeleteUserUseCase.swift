//
//  DeleteUserUseCase.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation

struct DeleteUserUseCase {
    let repository: UserRepository

    func execute(id: UUID) async throws {
        try await repository.deleteUser(id: id)
    }
}
