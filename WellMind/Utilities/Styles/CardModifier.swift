//
//  CardModifier.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import SwiftUI

struct CardModifier: ViewModifier {
    var cornerRadius: CGFloat = 8
    var x: CGFloat = 6, y: CGFloat = 8

    func body(content: Content) -> some View {
        content
            .background(.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 2)
            )
    }
}

extension View {
    func card(cornerRadius: CGFloat = 8, x: CGFloat = 6, y: CGFloat = 8) -> some View {
        modifier(CardModifier(cornerRadius: cornerRadius, x: x, y: y))
    }
}
