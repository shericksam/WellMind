//
//  UserMapper.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 14/05/25.
//

extension User {
    func toEntity() -> UserModel {
        .init(id: id, name: name, email: email, birthday: birthday, gender: gender, goals: goals, timestamp: timestamp)
    }
}

extension UserModel {
    func toDomain() -> User {
        .init(id: id, name: name, email: email, birthday: birthday, gender: gender, goals: goals, timestamp: timestamp)
    }
}
