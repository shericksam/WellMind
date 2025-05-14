//
//  UserLocalDataSource.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation
import SwiftData

protocol UserLocalDataSource {
    func fetchUsers() async throws -> [User]
    func saveUsers(_ users: [User]) async throws
    func deleteUser(id: Int) async throws
}

final class UserLocalDataSourceSwiftData: UserLocalDataSource {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchUsers() async throws -> [User] {
//        let descriptor = FetchDescriptor<UserModel>()
//        let models = try context.fetch(descriptor)
//        return models.map { User(id: $0.id, name: $0.name, email: $0.email) }
        []
    }

    func saveUsers(_ users: [User]) async throws {
//        users.forEach { user in
//            let model = UserModel(id: user.id, name: user.name, email: user.email)
//            context.insert(model)
//        }
//        try context.save()
    }

    func deleteUser(id: Int) async throws {
//        let descriptor = FetchDescriptor<UserModel>(predicate: #Predicate { $0.id == id })
//        let results = try context.fetch(descriptor)
//        results.forEach { context.delete($0) }
//        try context.save()
    }

}

