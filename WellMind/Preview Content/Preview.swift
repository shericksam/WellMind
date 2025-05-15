//
//  Preview.swift
//  AppUsers
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import SwiftData

struct Preview {
    
    let modelContainer: ModelContainer
    init() {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            modelContainer = try ModelContainer(for: UserModel.self, configurations: config)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    func addExamples(_ examples: [UserModel]) {
        Task { @MainActor in
            examples.forEach { example in
                modelContainer.mainContext.insert(example)
            }
        }
        
    }
}
