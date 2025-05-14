//
//  DIContainer+Welcome.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import SwiftUI

extension DIContainer {
    @MainActor
    static func makeWelcomeView() -> some View {
        let viewModel = WelcomeViewModel()
        return WelcomeView(viewModel: viewModel)
    }
}
