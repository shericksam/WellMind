//
//  UserModel.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation
import SwiftData

@Model
class UserModel {
    @Attribute(.unique) var id: UUID
    var name: String
    var email: String
    var birthday: Date
    var gender: Gender
    var goals: [WellnessGoal]
    
    init(id: UUID, name: String, email: String, birthday: Date, gender: Gender, goals: [WellnessGoal]) {
        self.id = id
        self.name = name
        self.email = email
        self.birthday = birthday
        self.gender = gender
        self.goals = goals
    }
}
