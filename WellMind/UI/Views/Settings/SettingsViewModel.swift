//
//  SettingsViewModel.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 14/05/25.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var title: String = "Hi!"
}