//
//  GameOfSet.swift
//  SetCardGame
//
//  Created by coriv on 8/20/21.
//

import Foundation

struct GameOfSet<Card> where Card: CardType {
    private(set) var deck: [Card]
    private(set) var dealtCards: [Card]
    private(set) var discardPile: [Card] // Store matched cards here for display
    private(set) var score = 0
    private var selectedCards: [Card] {
        dealtCards.filter{ $0.isSelected }
    }
    
    private(set) var set = ""
    
    init(cards: [Card]) {
        deck = cards.shuffled()
        dealtCards = []
        discardPile = []
    }
    
    var deckCount: Int {
        return deck.count
    }
    var selectedCount: Int {
        return selectedCards.count
    }
    
    
    mutating func choose(_ card: Card) {
        guard selectedCards.count != 3 else {
            return cardSetCheck()
        }
        print("Card chosen \(card) and number of selected cards \(selectedCards.count)")
        for index in dealtCards.indices {
            if dealtCards[index] == card {
                dealtCards[index].isSelected.toggle()
            }
        }
        if selectedCount == 3 {
            print("Selected cards is now 3 need to check")
//            return cardSetCheck()
            
        }
    }
    
    mutating func dealInitialCards() {
        guard dealtCards.count < 81 else {
            return print("No more cards")
        }
        let newCards = deck.prefix(initialCards)
        for cards in newCards {
            dealtCards.append(cards)
        }
        deck = Array(deck.dropFirst(initialCards))
        print("Cards in game: \(dealtCards.count), Cards in deck: \(deck.count)")
    }
    
    mutating func dealMoreCards(){
        guard dealtCards.count < 81 else {
            return print("No more cards")
        }
        // Draw Cards
        let newCards = deck.prefix(cardsToDeal)
        for cards in newCards {
            dealtCards.append(cards)
        }
        deck = Array(deck.dropFirst(3))
        print("Cards in game: \(dealtCards.count), Cards in deck: \(deck.count)")
    }
    
    
    mutating func unselectCards(){
        // All cards should now be unselected
        for index in dealtCards.indices {
            if selectedCards.contains(dealtCards[index]) {
                dealtCards[index].isSelected = false
            }
        }
    }
    
    mutating func cardSetCheck(){
        var colorMatch: Bool {
            if (selectedCards[0].color == selectedCards[1].color && selectedCards[1].color == selectedCards[2].color) || //the same color feature
                (selectedCards[0].color != selectedCards[1].color && selectedCards[1].color != selectedCards[2].color && selectedCards[2].color != selectedCards[0].color) { //no color feature is similar
                return true }
            else { return false}
        }
        var figureMatch: Bool {
            if (selectedCards[0].figure == selectedCards[1].figure && selectedCards[1].figure == selectedCards[2].figure) || //the same color feature
                (selectedCards[0].figure != selectedCards[1].figure && selectedCards[1].figure != selectedCards[2].figure && selectedCards[2].figure != selectedCards[0].figure) { //no color feature is similar
                return true}
            else { return false }
        }
        
        var numberMatch: Bool {
            if (selectedCards[0].number == selectedCards[1].number && selectedCards[1].number == selectedCards[2].number) || //the same color feature
                (selectedCards[0].number != selectedCards[1].number && selectedCards[1].number != selectedCards[2].number && selectedCards[2].number != selectedCards[0].number) { //no color feature is similar
                return true }
            else { return false }
        }
        
        var shadingMatch: Bool {
            if (selectedCards[0].shading == selectedCards[1].shading && selectedCards[1].shading == selectedCards[2].shading) ||                (selectedCards[0].shading != selectedCards[1].shading && selectedCards[1].shading != selectedCards[2].shading && selectedCards[2].shading != selectedCards[0].shading) {
                return true }
            else { return false }
        }
        
        if (colorMatch && figureMatch && numberMatch && shadingMatch) {
            print("SET!!")
            set = "SET"
            // Copy cards to discard pile, and then remove all cards in dealtcards that are in discardpilea
            score += setScore
            for cards in selectedCards {
                discardPile.append(cards)
            }
            print("discard pile: \(discardPile.count)")
            dealtCards.removeAll(where: {discardPile.contains($0)}) //
            
            
            
        } else {
            score += notSetScore
            print("NOT SET!!")
            set = "NOT SET"
            unselectCards()
        }
    }
    
    // MARK: Constants
    let setScore = 5
    let notSetScore = -3
    
    let cardsToDeal = 3
    let initialCards = 12
}
