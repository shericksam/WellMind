//
//  APIClient.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

class APIClient {
    static let shared = APIClient()
    
    private let baseURL: String
    private let token: String?
    
    private init(baseURL: String = "https://api.example.com", token: String? = nil) {
        self.baseURL = baseURL
        self.token = token
    }
    
    func request(path: String, method: HTTPMethod = .GET, headers: [String: String]? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseURL + path) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
    func requestAsync(path: String, method: HTTPMethod = .GET, headers: [String: String]? = nil) async throws -> Data {
        guard let url = URL(string: baseURL + path) else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}