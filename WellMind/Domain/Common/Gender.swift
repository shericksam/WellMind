//
//  Gender.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 13/05/25.
//

enum Gender: String, Codable, CaseIterable, Identifiable {
    case male
    case female
    case other
    case unspecified
    
    var id: String { self.rawValue }
}
