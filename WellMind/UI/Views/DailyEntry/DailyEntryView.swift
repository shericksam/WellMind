//
//  DailyEntryView.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 14/05/25.
//

import SwiftUI

struct DailyEntryView: View {
    @StateObject var viewModel: DailyEntryViewModel

    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.largeTitle)
                .padding()
        }
        .navigationTitle("DailyEntrys")
    }
}

#Preview {
    DIContainer.makeDailyEntryView()
}
