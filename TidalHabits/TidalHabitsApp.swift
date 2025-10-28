//
//  TidalHabitsApp.swift
//  TidalHabits
//
//  Created by Rain Hu on 2025/10/29.
//

import SwiftUI

@main
struct TidalHabitsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
