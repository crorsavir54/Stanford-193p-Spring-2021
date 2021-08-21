//
//  CardView.swift
//  MemoryGame
//
//  Created by coriv on 8/10/21.
//

import SwiftUI

struct CardView: View {
    var card: MemoryGame<String>.Card
    var cardColor: Color = .white

    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3.0, antialiased: true)
                Text(card.content).font(.largeTitle)
            } else {
                shape.fill(RadialGradient(gradient: Gradient(colors: [cardColor, .black]), center: .center, startRadius: 2, endRadius: 650))
            }
        }
    }
}

