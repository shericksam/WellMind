//
//  GoalItemView.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 14/05/25.
//

import SwiftUI

struct GoalItemView: View {
    let goal: WellnessGoal
    let isSelected: Bool
    let onTap: () -> Void

    @State private var isPressed = false

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: goal.icon)
                .font(.title)
                .foregroundColor(isSelected ? .primaryColor : .gray)

            Text(goal.rawValue.localized)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
        .frame(minWidth: 120, minHeight: 100)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(isSelected ? Color.primaryColor.opacity(0.1) : Color.clear)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.primaryColor : Color.gray.opacity(0.3), lineWidth: 2)
        )
        .scaleEffect(isPressed ? 0.95 : (isSelected ? 1.05 : 1.0))
        .animation(.spring(response: 0.3, dampingFraction: 0.4), value: isPressed)
        .onTapGesture {
            isPressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
                withAnimation {
                    onTap()
                }
            }
        }
    }
}
