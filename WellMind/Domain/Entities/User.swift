//
//  User.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation

struct User: Identifiable {
    var id: UUID
    var name: String
    var email: String
    var birthday: Date
    var gender: Gender
    var goals: [WellnessGoal]
    
    init(id: UUID = UUID(), name: String  = "", email: String  = "", birthday: Date  = .now, gender: Gender = .unspecified , goals: [WellnessGoal] = []) {
        self.id = id
        self.name = name
        self.email = email
        self.birthday = birthday
        self.gender = gender
        self.goals = goals
    }
}
