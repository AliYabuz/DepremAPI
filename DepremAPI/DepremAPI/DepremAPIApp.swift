//
//  DepremAPIApp.swift
//  DepremAPI
//
//  Created by Ali on 16.02.2023.
//

import SwiftUI

@main
struct DepremAPIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
