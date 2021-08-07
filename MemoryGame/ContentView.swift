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









struct ContentView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            
    }
}
