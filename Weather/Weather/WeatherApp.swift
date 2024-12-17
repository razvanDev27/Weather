//
//  WeatherApp.swift
//  Weather
//
//  Created by Razvan Copaciu on 17.12.2024.
//

import SwiftUI
import SwiftData

@main
struct WeatherApp: App {
    let userDataProvider: UserDataProvider = UserDataProvider()

    var body: some Scene {
        WindowGroup {
            ContentView(userDataProvider: userDataProvider)
        }
    }
}
