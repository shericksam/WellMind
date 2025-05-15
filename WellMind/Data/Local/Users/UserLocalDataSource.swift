//
//  UserLocalDataSource.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation
import SwiftData

protocol UserLocalDataSource {
    func save(user: User) async throws
    func load() async throws -> User?
    func delete(id: UUID) async throws
}

final class UserLocalDataSourceSwiftData: UserLocalDataSource {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func save(user: User) async throws {
        let entity = user.toEntity()
        context.insert(entity)
        try context.save()
    }
    
    func load() async throws -> User? {
        var fetchRequest = FetchDescriptor<UserModel>()
        fetchRequest.fetchLimit = 1
        let results = try context.fetch(fetchRequest)
        return results.first?.toDomain()
    }

    func delete(id: UUID) async throws {
        let descriptor = FetchDescriptor<UserModel>(predicate: #Predicate { $0.id == id })
        let results = try context.fetch(descriptor)
        results.forEach { context.delete($0) }
        try context.save()
    }
    
}

