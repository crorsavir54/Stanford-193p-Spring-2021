//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by coriv on 8/6/21.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    // MARK: - Access to Model
    @Published private var model: MemoryGame<String>
    var gameTheme: Theme
    var cards: [Card] {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    init() {
        let theme = Theme.themes.randomElement()!
        gameTheme = theme
        model = EmojiMemoryGame.createMemoryGame(with: gameTheme)
    }

    static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        
        let emojis = theme.emojis.shuffled()
        let pairsOfCards = theme.cardsNumber ?? Int.random(in: 2...emojis.count)
        
        
        return MemoryGame<String>(numberOfPairsOfCards: pairsOfCards, createCardContent: { pairIndex in
                            return emojis[pairIndex]})
    }
    

    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func resetGame() {
        gameTheme = Theme.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(with: gameTheme)
    }
}
  
 
