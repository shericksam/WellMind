//
//  UserRepository.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation

protocol UserRepository {
    func fetchUsers() async throws -> [User]
    func addUsers(users: [User]) async throws
    func deleteUser(id: Int) async throws
}
