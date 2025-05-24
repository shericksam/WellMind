//
//  SummaryCard.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 14/05/25.
//

import SwiftUI

struct SummaryCard: View {
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(AppColors.onBackground.opacity(0.8))

            Text(value)
                .font(.title2.bold())
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .padding()
        .card(showBorder: false)
    }
}
#Preview {
    SummaryCard(title: "Title", value: "😊", color: AppColors.secondary)
        .padding()
    SummaryCard(title: "Title", value: "7h 45m", color: AppColors.tertiary)
        .padding()
    SummaryCard(title: "Title", value: "---", color: AppColors.outline)
        .padding()
}
