//
//  DIContainer+Settings.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 14/05/25.
//

import SwiftUI

extension DIContainer {
    @MainActor
    static func makeSettingsView() -> some View {
        let viewModel = SettingsViewModel()
        return SettingsView(viewModel: viewModel)
    }
}
