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

    func fetchUsers() async throws -> [User] {
        let users = try await remote.fetchUsers(path: "/users", method: "GET", headers: nil)
        try await local.saveUsers(users)
        return try await local.fetchUsers()
    }
    func addUsers(users: [User]) async throws {
        try await remote.addUsers(users: users, path: "/users", method: "POST", headers: nil)
        try await local.saveUsers(users)
    }
    
    func deleteUser(id: Int) async throws {
        try await remote.deleteUser(id: id, path: "/users", method: "DELETE", headers: nil)
        try await local.deleteUser(id: id)
    }
}

