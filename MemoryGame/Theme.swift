//
//  Theme.swift
//  MemoryGame
//
//  Created by coriv on 8/7/21.
//

import Foundation
import SwiftUI

struct Theme {
    var name: String
    var emojis: [String]
    var cardsNumber: Int?
    var color: Color
    static let smileys = Theme(name: "Smileys" , emojis: ["😃","😃","☺️","😎","😇","🤬","😱","🥴","😵‍💫","😵"], cardsNumber: 10, color: .yellow)
    static let animals = Theme(name: "Animals" , emojis: ["🐶","🐭","🐸","🐴","🐷","🐔","🦊"], color: .blue)
    static let vehicles = Theme(name: "Vehicles" , emojis: ["🚗","🚕","🚌","🏎","🚛","🚘","🚜","🚓"], cardsNumber: 8, color: .green)
    static let persons = Theme(name: "Persons" , emojis: ["👩🏻‍🔬","👩🏻‍🎨","👩🏽‍⚖️","👰🏿‍♂️","🦸🏼","🎅🏼","🦹🏻‍♀️","💆🏼‍♀️","🧖🏽"], color: .gray)
    static let sports = Theme(name: "Sports" , emojis: ["⚽️","🏈","🏀","🎾","🏉","🏓","🥊","🤾🏻","🏄🏻‍♀️","🤺"], cardsNumber: 10, color: .red)
    static let halloween = Theme(name: "Halloween" , emojis: ["🧛🏻‍♀️","🧚","🧜🏻","👻","🎃","👹"], cardsNumber: 6, color: .orange)
    
    static var themes = [smileys, animals, vehicles, persons, sports, halloween]
    
}
