//
//  ExplorePlacesApp.swift
//  ExplorePlaces
//
//  Created by Dhruv Rasikbhai Jivani on 10/30/25.
//

import SwiftUI
import CoreData

@main
struct ExplorePlacesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
