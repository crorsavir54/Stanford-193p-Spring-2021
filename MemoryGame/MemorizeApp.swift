//
//  MemorizeApp.swift
//  MemoryGame
//
//  Created by coriv on 8/6/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var themeChooser = ThemeChooser(named: "Default")
    var body: some Scene {
        WindowGroup {
            ThemesChooser()
                .environmentObject(themeChooser)
        }
    }
}
