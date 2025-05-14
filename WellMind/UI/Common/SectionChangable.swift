//
//  SectionChangable.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 14/05/25.
//

import SwiftUI

protocol SectionChangable {
    associatedtype Section: CaseIterable & Equatable
}

extension SectionChangable {
    mutating func changeSection(_ option: ControlSection) {
        let allCases = Section.allCases
        guard let currentIndex = allCases.firstIndex(of: self as! Self.Section) else {
            return
        }
        let currentIndexInt = allCases.distance(from: allCases.startIndex, to: currentIndex)

        switch option {
        case .previous:
            let previousIndex = currentIndexInt - 1
            if previousIndex >= 0 {
                withAnimation {
                    self = allCases[allCases.index(allCases.startIndex, offsetBy: previousIndex)] as! Self
                }
            }
        case .next:
            let nextIndex = currentIndexInt + 1
            if nextIndex < allCases.count {
                withAnimation {
                    self = allCases[allCases.index(allCases.startIndex, offsetBy: nextIndex)] as! Self
                }
            }
        }
    }
}

