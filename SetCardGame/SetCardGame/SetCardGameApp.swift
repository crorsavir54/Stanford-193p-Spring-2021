//
//  SetCardGameApp.swift
//  SetCardGame
//
//  Created by coriv on 8/20/21.
//

import SwiftUI

@main
struct SetCardGameApp: App {
    var body: some Scene {
        WindowGroup {
            SetGameView(game: SetGame(cards: SetCardContent.generateAll()))
        }
    }
}
