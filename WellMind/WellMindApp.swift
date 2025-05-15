//
//  WellMindApp.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import SwiftUI
import SwiftData

@main
struct WellMindApp: App {
    @AppStorage("hasSeenWelcome") var hasSeenWelcome: Bool = false

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            UserModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        var retryCount = 0
        while retryCount < 3 {
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                print("Could not create ModelContainer: \(error)")
                retryCount += 1
                do {
                    let urlApp = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last
                    let url = urlApp!.appendingPathComponent("default.store")
                    if FileManager.default.fileExists(atPath: url.path) {
                        try FileManager.default.removeItem(atPath: url.path)
                    }
                    print("ModelContainer deleted successfully")
                } catch {
                    print("Could not delete current ModelContainer: \(error)")
                }
            }
        }
        fatalError("Could not create ModelContainer after 3 tries")
    }()

    var body: some Scene {
        WindowGroup {
            if hasSeenWelcome {
                DIContainer.makeUsersListView(context: sharedModelContainer.mainContext)
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            } else {
                DIContainer.makeWelcomeView()
                    .transition(.move(edge: .leading).combined(with: .opacity))
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
