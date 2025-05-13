//
//  UserRemoteDataSource.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation

protocol UserRemoteDataSource {
    func fetchUsers(path: String, method: String, headers: [String: String]?) async throws -> [User]
    func addUsers(users: [User], path: String, method: String, headers: [String: String]?) async throws
    func deleteUser(id: Int, path: String, method: String, headers: [String: String]?) async throws
}

final class UserRemoteDataSourceImpl: UserRemoteDataSource {
    static let shared = UserRemoteDataSourceImpl()
    
    private let baseURL: String
    private let token: String?
    
    private init(baseURL: String = "https://jsonplaceholder.typicode.com", token: String? = nil) {
        self.baseURL = baseURL
        self.token = token
    }

    func fetchUsers(path: String = "/users", method: String = "GET", headers: [String: String]? = nil) async throws -> [User] {
        guard let url = URL(string: baseURL + path) else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let dtos = try JSONDecoder().decode([UserDTO].self, from: data)
        return dtos.map { User(id: $0.id, name: $0.name, email: $0.email) }
    }
    
    func addUsers(users: [User], path: String, method: String, headers: [String : String]?) async throws {
//        code to add users
    }
    
    func deleteUser(id: Int, path: String, method: String, headers: [String : String]?) async throws {
//        code to delete user
    }
}
