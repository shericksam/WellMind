//
//  APIClientTests.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import XCTest
@testable import WellMind

final class APIClientTests: XCTestCase {
    func test_fetchUsers_returnsMockedResponse() async throws {
        let apiClient = MockAPIClient()
        let users = try await apiClient.fetchUsers(path: "/users", method: "GET", headers: nil)
        XCTAssertEqual(users.count, 2)
        XCTAssertEqual(users.first?.name, "Erick")
    }
}
