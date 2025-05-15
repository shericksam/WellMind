//
//  UserRepositoryImpl.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation

final class UserRepositoryImpl: UserRepository {
    private let remote: UserRemoteDataSource
    private let local: UserLocalDataSource

    init(remote: UserRemoteDataSource, local: UserLocalDataSource) {
        self.remote = remote
        self.local = local
    }

    func getUser() async throws -> User? {
//        let users = try await remote.fetchUsers(path: "/users", method: "GET", headers: nil)
        try await local.load()
    }

    func saveUser(_ user: User) async throws {
        try await local.save(user: user)
    }
    
    func deleteUser(id: UUID) async throws {
//        try await local.deleteUser(id: id)
    }
}

