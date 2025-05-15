//
//  User.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation

struct User: Identifiable {
    let id: UUID = UUID()
    var name: String = ""
    var email: String = ""
    var birthday: Date = .now
    var gender: Gender = .unspecified
    var goals: [WellnessGoal] = []
}
