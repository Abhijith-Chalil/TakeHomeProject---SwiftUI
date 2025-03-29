//
//  TakeHomeProjectApp.swift
//  TakeHomeProject
//
//  Created by Abhijith Chalil on 15/03/25.
//

import SwiftUI

@main
struct TakeHomeProjectApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                PeopleView()
                    .tabItem {
                        Symbols.person
                        Text("Home")
                    }
                
                SettingsView()
                    .tabItem {
                        Symbols.gear
                        Text("Settings")
                    }
            }
        }
    }
}
