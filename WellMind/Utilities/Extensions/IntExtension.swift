//
//  IntExtension.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation
import SwiftUI

extension Int {
    func toString() -> String {
        return String(self)
    }
    
    func toDouble() -> Double {
        return Double(self)
    }
    
    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
    
    func toFloat() -> Float {
        return Float(self)
    }
}
