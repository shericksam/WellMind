//
//  WellnessGoal.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 13/05/25.
//

import SwiftUI

enum WellnessGoal: String, Codable, CaseIterable, Identifiable {
    case SleepBetter = "sleep_better"
    case ReduceStress = "reduce_stress"
    case ImproveEnergy = "improve_energy"
    case EatHealthier = "eat_healthier"
    case ExerciseMore = "exercise_more"
    
    var id: String {
        rawValue
    }
    
    var icon: String {
        switch self {
        case .SleepBetter:
            "powersleep"
        case .ReduceStress:
            "sparkles"
        case .ImproveEnergy:
            "party.popper.fill"
        case .EatHealthier:
            "carrot.fill"
        case .ExerciseMore:
            "figure.run"
        }
    }
}
