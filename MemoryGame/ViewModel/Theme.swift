//
//  Theme.swift
//  MemoryGame
//
//  Created by coriv on 8/7/21.
//

import Foundation
import SwiftUI

struct Theme: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var emojis: String
    var cardsNumber: Int
    var color: UIColor.RGB
    
    
//    static let vehicles = Theme(name: "Vehicles", emojis: "🚙🚗🚘🚕🚖🏎🚚🛻", cardsNumber: 8, color: UIColor.getRGB(.red))
//    static var themes = [vehicles]
}

class ThemeChooser: ObservableObject {
    
    var name: String
    
    @Published var themes = [Theme]() {
        didSet {
            if themes.isEmpty {
                insertTheme(theme: Theme(name: "Vehicles", emojis: "🚙🚗🚘🚕🚖🏎🚚🛻", cardsNumber: 2, color: UIColor.getRGB(.systemGreen)))
                insertTheme(theme: Theme(name: "Balls", emojis: "🏈⚾️🏀⚽️", cardsNumber: 4, color: UIColor.getRGB(.orange)))
                insertTheme(theme: Theme(name: "Smileys", emojis: "😝😜🤪🤨🧐", cardsNumber: 2, color: UIColor.getRGB(.systemBlue)))
                insertTheme(theme: Theme(name: "Weather", emojis: "☀️🌤⛅️", cardsNumber: 2, color: UIColor.getRGB(.red)))
//                    themes = [Theme.vehicles]
            }
            storeInUserDefaults()
        }
    }
    
    init(named name: String) {
        self.name = name
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            if let decoded = try? JSONDecoder().decode([Theme].self, from: data) {
                themes = decoded
                return
            }
        }
        
        insertTheme(theme: Theme(name: "Vehicles", emojis: "🚙🚗🚘🚕🚖🏎🚚🛻", cardsNumber: 2, color: UIColor.getRGB(.systemGreen)))
        insertTheme(theme: Theme(name: "Balls", emojis: "🏈⚾️🏀⚽️", cardsNumber: 2, color: UIColor.getRGB(.orange)))
        insertTheme(theme: Theme(name: "Smileys", emojis: "😝😜🤪🤨🧐", cardsNumber: 2, color: UIColor.getRGB(.systemBlue)))
        insertTheme(theme: Theme(name: "Weather", emojis: "☀️🌤⛅️", cardsNumber: 2, color: UIColor.getRGB(.red)))

//        themes = [Theme.vehicles]
//
//        if themes.isEmpty {
        
        
//        }

        
    }

    // MARK: - Persistence
    
    private var userDefaultsKey: String {
        "SaveThemes:" + name
    }
    
    private func storeInUserDefaults(){
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedThemes = try? JSONDecoder().decode([Theme].self, from: jsonData) {
            themes = decodedThemes
        }
    }
    
    // MARK: - Intent
    
    func removeTheme(_ theme: Theme) {
        if let index = themes.firstIndex(of: theme) {
            themes.remove(at: index)
        }
    }
    
    func insertTheme(theme: Theme) {
        objectWillChange.send()
        if let index = themes.firstIndex(of: theme) {
            themes[index] = theme
        } else {
            themes.append(theme)
        }
    }
}
