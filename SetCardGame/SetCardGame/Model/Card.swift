//
//  Card.swift
//  SetCardGame
//
//  Created by coriv on 8/21/21.
//

import Foundation

protocol CardType: Equatable {
    
    associatedtype Number: Equatable
    associatedtype Figure: Equatable
    associatedtype Coloring: Equatable
    associatedtype Shading: Equatable
    
    var number: Number {get}
    var figure: Figure {get}
    var color: Coloring {get}
    var shading: Shading {get}
    var id: UUID {get}
    var isSelected: Bool {get set}
    
    static func generateAll() -> [Self]
}
