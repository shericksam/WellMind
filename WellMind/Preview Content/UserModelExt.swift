//
//  UserModelExt.swift
//  AppUsers
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation

extension UserModel {
    static var sampleItem: UserModel {
        UserModel(id: UUID(), name: "Test 1", email: "a1@a.com", birthday: Date(), gender: .male, goals: [.ImproveEnergy])
    }
}
