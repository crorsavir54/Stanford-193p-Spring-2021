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
    var dealtCards: [SetCardContent]{
        return game.dealtCards
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
