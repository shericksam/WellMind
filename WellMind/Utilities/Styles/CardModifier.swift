//
//  CardModifier.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import SwiftUI
struct CardModifier: ViewModifier {
    var cornerRadius: CGFloat = 22
    var showBorder: Bool = false
    var borderColor: Color = AppColors.outline
    var borderWidth: CGFloat = 1
    var shadowRadius: CGFloat = 6
    var shadowOpacity: Double = 0.08

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(AppColors.surface)
            )
            .if(showBorder) { view in
                view.overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: borderWidth)
                )
            }
            .shadow(color: Color.black.opacity(shadowOpacity),
                    radius: shadowRadius, x: 0, y: 2)
    }
}

extension View {
    func card(
        cornerRadius: CGFloat = 16,
        showBorder: Bool = false,
        borderColor: Color = AppColors.outline,
        borderWidth: CGFloat = 1,
        shadowRadius: CGFloat = 6,
        shadowOpacity: Double = 0.08
    ) -> some View {
        modifier(CardModifier(
            cornerRadius: cornerRadius,
            showBorder: showBorder,
            borderColor: borderColor,
            borderWidth: borderWidth,
            shadowRadius: shadowRadius,
            shadowOpacity: shadowOpacity
        ))
    }
}

