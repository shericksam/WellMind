//
//  GetUserUseCase.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation

struct GetUserUseCase {
    let repository: UserRepository

    func execute() async throws -> User? {
        try await repository.getUser()
    }
}
