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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            FruitListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }

}
