//
//  SettingsView.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 14/05/25.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel: SettingsViewModel

    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.largeTitle)
                .padding()
        }
        .navigationTitle("Settingss")
    }
}

#Preview {
    DIContainer.makeSettingsView()
}
