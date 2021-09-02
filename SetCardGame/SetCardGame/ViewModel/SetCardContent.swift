//
//  SetCardContent.swift
//  SetCardGame
//
//  Created by coriv on 8/20/21.
//

import Foundation

struct SetCardContent: CardType, Identifiable, Hashable, Equatable {
   
    var number: Number
    var figure: Figure
    var color: Coloring
    var shading: Shading
    var id = UUID()
    var isSelected: Bool
    
    enum Number: Int, CaseIterable {
        case one = 1, two, three
    }
    enum Coloring: CaseIterable, Equatable{
        case blue, green, red
    }
    enum Figure: CaseIterable {
        case diamond, rectangle, capsule
    }
    enum Shading: String, CaseIterable {
        case solid, stripe, none
    }
    static func generateAll() -> [Self] {
        var cards = [Self]()
        for numbers in Number.allCases {
            for colors in Coloring.allCases {
                for figures in Figure.allCases {
                    for shadings in Shading.allCases {
                        cards.append(Self.init(number: numbers, figure: figures, color: colors, shading: shadings, isSelected: false))
                    }
                }
            }
        }
        return cards
    }
    
}
