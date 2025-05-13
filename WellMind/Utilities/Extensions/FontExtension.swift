//
//  FontExtension.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation
import SwiftUI

extension Font {
    static func customFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        let fontName = "Poppins-\(weight)"
        return Font.custom(fontName, size: size)
    }
    
    static func customFontBold(size: CGFloat) -> Font {
        return customFont(size: size, weight: .bold)
    }
    
    static func customFontMedium(size: CGFloat) -> Font {
        return customFont(size: size, weight: .medium)
    }
    
    static func customFontSemiBold(size: CGFloat) -> Font {
        return customFont(size: size, weight: .semibold)
    }
}
