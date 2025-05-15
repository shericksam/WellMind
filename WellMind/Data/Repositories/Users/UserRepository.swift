//
//  UserRepository.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation

protocol UserRepository {
    func saveUser(_ user: User) async throws
    func getUser() async throws -> User?
    func deleteUser(id: UUID) async throws
}
