//
//  EmojiMemoryGameView.swift
//  MemoryGame
//
//  Created by coriv on 7/24/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack{
            HStack{
                Text("Memorize!")
                Text("Score: \(viewModel.score)")
            }
            .font(.largeTitle)
            Text("Theme: \(viewModel.gameTheme.name)")

            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card, cardColor: viewModel.gameTheme.color)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }.foregroundColor(viewModel.gameTheme.color)
            HStack{
                Button(action: {
                    viewModel.resetGame()
                }, label: {
                    Text("Reset Game")
                })
            }
        }
        .padding(.horizontal)
    }
}


struct ContentView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(viewModel: game)
            
    }
}
