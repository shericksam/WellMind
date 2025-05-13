//
//  UserDTO.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation

struct UserDTO: Decodable {
    let id: Int
    let name: String
    let email: String
}
