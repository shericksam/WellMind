//
//  FullScreenStyle.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import SwiftUI

struct FullScreenStyle: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                content
                Spacer()
            }
            Spacer()
        }
    }
}

extension View {
    func showFullScreen() -> some View {
        modifier(FullScreenStyle())
    }
}
