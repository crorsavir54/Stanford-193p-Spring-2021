//
//  ContentView.swift
//  MemoryGame
//
//  Created by coriv on 7/24/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack{
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.medium)
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
                
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3.0, antialiased: true)
                Text(card.content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
    }
}









struct ContentView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            
    }
}
