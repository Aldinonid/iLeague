//
//  iLeagueApp.swift
//  iLeague
//
//  Created by Aldino Efendi on 2024-06-03.
//

import SwiftUI
import SwiftData

@main
struct iLeagueApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Player.self,
            MatchModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
