//
//  MemoryApp.swift
//  MemoryGame
//
//  Created by coriv on 8/6/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    
    private(set) var cards: Array<Card>
    private(set) var score = 0
    private var firstCardIndex: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = firstCardIndex {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                }
                firstCardIndex = nil
            } else {

                for index in cards.indices {
                    if !cards[index].isMatched{
                        cards[index].isFaceUp = false
                    }
                }
                if cards[chosenIndex].FacedUp{
                    score -= 1
                }
                firstCardIndex = chosenIndex
            }
        cards[chosenIndex].isFaceUp.toggle()
        print("chosen \(cards[chosenIndex])")
            cards[chosenIndex].FacedUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(isFaceUp: false, isMatched: false, content: content, id: pairIndex*2))
            cards.append(Card(isFaceUp: false, isMatched: false, content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    } 
    
    struct Card: Identifiable {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
        var FacedUp: Bool = false
        var id: Int
        
    }
}
 
