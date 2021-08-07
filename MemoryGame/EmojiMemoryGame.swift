//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by coriv on 8/6/21.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    static var emojis = ["🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚜"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 2, createCardContent: { pairIndex in
                            return EmojiMemoryGame.emojis[pairIndex]})
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
  
 
