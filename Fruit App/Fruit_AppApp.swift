//
//  Fruit_AppApp.swift
//  Fruit App
//
//  Created by Calum Maclellan on 17/06/2021.
//

import SwiftUI

@main
struct Fruit_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
