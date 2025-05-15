//
//  ColorExtension.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation
import UIKit
import SwiftUI

extension Color {
    static let primaryColor = Color("PrimaryColor")
    static let secondaryColor = Color("SecondaryColor")
    static let backgroundColor = Color("BackgroundColor")
    static let darkBackgroundColor = Color("DarkBackgroundColor")
    static let purpleColor = Color("PurpledColor")
    static let blueColor = Color("BlueColor")
    static let successColor = Color("SuccessColor")
    static let warningColor = Color("WarningColor")
    static let textPrimaryColor = Color("TextPrimary")
    static let textSecondaryColor = Color("TextSecondary")
    
    var uiColor: UIColor {
        if #available(iOS 14.0, *) {
            return UIColor(self)
        }

        let components = self.components()
        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }

    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        }
        return (r, g, b, a)
    }

    func darken(_ amount: Double) -> Color {
        return self.opacity(1 - amount)
    }
}

enum AppColors {
    static let primary = Color("primary")
    static let onPrimary = Color("onPrimary")
    static let primaryContainer = Color("primaryContainer")
    static let onPrimaryContainer = Color("onPrimaryContainer")
    static let secondary = Color("secondary")
    static let onSecondary = Color("onSecondary")
    static let secondaryContainer = Color("secondaryContainer")
    static let onSecondaryContainer = Color("onSecondaryContainer")
    static let tertiary = Color("tertiary")
    static let onTertiary = Color("onTertiary")
    static let tertiaryContainer = Color("tertiaryContainer")
    static let onTertiaryContainer = Color("onTertiaryContainer")
    static let error = Color("error")
    static let onError = Color("onError")
    static let errorContainer = Color("errorContainer")
    static let onErrorContainer = Color("onErrorContainer")
    static let background = Color("background")
    static let onBackground = Color("onBackground")
    static let surface = Color("surface")
    static let onSurface = Color("onSurface")
    static let surfaceVariant = Color("surfaceVariant")
    static let onSurfaceVariant = Color("onSurfaceVariant")
    static let outline = Color("outline")
    static let outlineVariant = Color("outlineVariant")
    static let shadow = Color("shadow")
    static let scrim = Color("scrim")
    static let inverseSurface = Color("inverseSurface")
    static let inverseOnSurface = Color("inverseOnSurface")
    static let inversePrimary = Color("inversePrimary")
    static let primaryFixed = Color("primaryFixed")
    static let onPrimaryFixed = Color("onPrimaryFixed")
    static let primaryFixedDim = Color("primaryFixedDim")
    static let onPrimaryFixedVariant = Color("onPrimaryFixedVariant")
    static let secondaryFixed = Color("secondaryFixed")
    static let onSecondaryFixed = Color("onSecondaryFixed")
    static let secondaryFixedDim = Color("secondaryFixedDim")
    static let onSecondaryFixedVariant = Color("onSecondaryFixedVariant")
    static let tertiaryFixed = Color("tertiaryFixed")
    static let onTertiaryFixed = Color("onTertiaryFixed")
    static let tertiaryFixedDim = Color("tertiaryFixedDim")
    static let onTertiaryFixedVariant = Color("onTertiaryFixedVariant")
    static let surfaceDim = Color("surfaceDim")
    static let surfaceBright = Color("surfaceBright")
    static let surfaceContainerLowest = Color("surfaceContainerLowest")
    static let surfaceContainerLow = Color("surfaceContainerLow")
    static let surfaceContainer = Color("surfaceContainer")
    static let surfaceContainerHigh = Color("surfaceContainerHigh")
    static let surfaceContainerHighest = Color("surfaceContainerHighest")
}
