//
//  ContentView.swift
//  Weather
//
//  Created by Razvan Copaciu on 17.12.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    let userDataProvider: UserDataProvider

    var body: some View {
        HomeView(userDataProvider: userDataProvider)
    }
}

#Preview {
    ContentView(userDataProvider: UserDataProvider())
}
