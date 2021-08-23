//
//  ContentView.swift
//  SetCardGame
//
//  Created by coriv on 8/20/21.
//

import SwiftUI


struct CardView: View {

    var card : SetCardContent
    
    var figureColor: Color {
        switch card.color {
        case .blue:
            return .blue
        case .green:
            return .green
        case .red:
            return .red
        }
    }
    
    var figureShading: String {
        switch card.shading {
        case .solid:
            return "solid"
        case .stripe:
            return "stripe"
        case .none:
            return "none"
        }
    }
    
    var body: some View {
        
        ZStack {
            GeometryReader { geometry in
                VStack{
                    if card.figure == .capsule {
                        ForEach(0..<card.number.rawValue, id: \.self) { _ in
                            CapsuleView(shade: figureShading, color: figureColor)
                                .frame(width: geometry.size.height/3, height: geometry.size.width/4, alignment: .center)
                        }
                    }
                    if card.figure == .rectangle {
                        ForEach(0..<card.number.rawValue, id: \.self) { _ in
                            RectangleView(shade: figureShading, color: figureColor)
                                .frame(width: geometry.size.height/3, height: geometry.size.width/4, alignment: .center)
                        }
                    }
                    if card.figure == .diamond {
                        ForEach(0..<card.number.rawValue, id: \.self) { _ in
                            DiamondView(shade: figureShading, color: figureColor)
                                .frame(width: geometry.size.height/3, height: geometry.size.width/4, alignment: .center)
                        }
                    }
                }
                
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                .background(
                    RoundedRectangle(
                        cornerRadius: 10,
                        style: .continuous
                    )
                    .fill(Color.white)
                )
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let card = SetCardContent(number: SetCardContent.Number.three, figure: SetCardContent.Figure.diamond, color: SetCardContent.Coloring.green, shading: SetCardContent.Shading.stripe, isSelected: false)
        CardView(card: card)
    }
}
