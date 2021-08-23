//
//  SetGame.swift
//  SetCardGame
//
//  Created by coriv on 8/20/21.
//

import Foundation

class SetGame: ObservableObject {
    @Published private var game: GameOfSet<SetCardContent>

    init(cards: [SetCardContent]) {
        game = GameOfSet(cards: cards.shuffled())
        game.dealInitialCards()
    }
    // MARK: Access to Model
    var deck: [SetCardContent]{
        return game.deck
    }
    var deckCount: Int {
        return game.deckCount
    }
    var selectedCount: Int {
        return game.selectedCount
    }
    var dealtCards: [SetCardContent]{
        return game.dealtCards
    }
    
    var discardPile: [SetCardContent]{
        return game.discardPile
    }
    
    var score: Int {
        return game.score
    }
    
    // MARK: Intent(s)
    func dealCards(){
        game.dealMoreCards()
    }

    func chooseCard(card: SetCardContent){
        game.choose(card)
    }

    func reset() {
        let cards = SetCardContent.generateAll()
        game = GameOfSet(cards: cards)
        game.dealInitialCards()
    }
}
