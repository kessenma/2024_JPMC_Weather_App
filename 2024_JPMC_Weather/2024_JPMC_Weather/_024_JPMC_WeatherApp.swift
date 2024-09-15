//
//  _024_JPMC_WeatherApp.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/14/24.
//

import SwiftUI

@main
struct _024_JPMC_WeatherApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
