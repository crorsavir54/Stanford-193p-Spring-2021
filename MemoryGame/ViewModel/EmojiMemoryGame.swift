//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by coriv on 8/6/21.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    var theme: Theme
    
    @Published var model: MemoryGame<String>
    
    init(theme: Theme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }

    
    private static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        
         let emojis = theme.emojis.map{String($0)}.shuffled()
         let pairsOfCards = theme.cardsNumber
         return MemoryGame<String>(numberOfPairsOfCards: pairsOfCards, createCardContent: { pairIndex in
                             return emojis[pairIndex]})
     }

    // MARK: - Access to Model

    var cards: [Card] {
        model.cards
    }

    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
}
  
 
