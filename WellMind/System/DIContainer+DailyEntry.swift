//
//  DIContainer+DailyEntry.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 14/05/25.
//

import SwiftUI

extension DIContainer {
    @MainActor
    static func makeDailyEntryView() -> some View {
        let viewModel = DailyEntryViewModel()
        return DailyEntryView(viewModel: viewModel)
    }
}
