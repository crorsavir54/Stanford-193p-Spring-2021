//
//  EmojiMemoryGameView.swift
//  MemoryGame
//
//  Created by coriv on 7/24/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    @EnvironmentObject var theme: ThemeChooser

    var body: some View {
        VStack{
            HStack{
                Text("Memorize!: \(game.theme.name)")
                    .font(.largeTitle)
                    .foregroundColor(Color(game.theme.color))
                    .layoutPriority(1)
            }.padding(.top)
            HStack {
                Text("Score:")
                    .font(.title).fontWeight(.medium)
                    .foregroundColor(Color(.black))
                Text("\(game.score)")
                    .font(.title).fontWeight(.bold)
                    .foregroundColor(game.score < 0 ? .pink : .blue)
            }
            Divider()
            Spacer()
            Grid(game.cards) { card in
                CardView(card: card, themeColor: Color(game.theme.color))
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.75)){
                            game.choose(card)
                        }
                        
                    }
                    .padding(5)
            }.foregroundColor(Color(game.theme.color))

            HStack{
                Button(action: {
                    withAnimation(.easeInOut) {
                        game.resetGame()
                    }
                }, label: {
                    Text("Reset Game")
                })
            }
        }
        .padding(.horizontal)
        .padding(.top, 15)
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = EmojiMemoryGame(theme: Theme.vehicles)
//        EmojiMemoryGameView(game: game)
//    }
//}
