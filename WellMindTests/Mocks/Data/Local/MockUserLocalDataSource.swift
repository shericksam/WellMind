//
//  MockUserLocalDataSource.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

@testable import WellMind

class MockUserLocalDataSource: UserLocalDataSource {
    var storedUsers: [User] = []
    var didCallSaveUsers = false

    func saveUsers(_ users: [User]) async throws {
        didCallSaveUsers = true
        storedUsers = users
    }

    func fetchUsers() async throws -> [User] {
        return storedUsers
    }

    func deleteUser(id: Int) async throws {
        storedUsers.removeAll { $0.id == id }
    }
}
