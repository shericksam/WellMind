//
//  ViewExtension.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 15/05/25.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool,
                                          transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
