//
//  SetGameView.swift
//  SetCardGame
//
//  Created by coriv on 8/20/21.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGame
    @State private var isTapped: Bool = false
    
    private let layout = [
        GridItem(.adaptive(minimum: 50)),
        GridItem(.adaptive(minimum: 50)),
        GridItem(.adaptive(minimum: 50)),
        GridItem(.adaptive(minimum: 50))
    ]
    
    var body: some View {
        VStack {
            ScoreAndReset
            DealtCards
            Decks
        }
    }
    
    var ScoreAndReset: some View {
        HStack{
            Text("Score: \(game.score)")
                .font(.title3)
                .padding(.leading)
            Spacer()
            Button(action: {
                    withAnimation {
                        game.reset()
                    }}, label: {
                        Text("RESET")
                            .font(.title3)
                    })
                .foregroundColor(.white)
                .padding(.horizontal, 15)
                .padding(.vertical, 6)
                .background(Color.pink)
                .cornerRadius(10)
        }.padding(.trailing)
    }
    
    var DealtCards: some View {
        ZStack {
            Color.gray.opacity(0.2)
                .ignoresSafeArea()
            VStack {
                ScrollView(content: {
                    LazyVGrid(columns: layout) {
                        ForEach(game.dealtCards) { card in
                            CardView(card: card)
                                .clipped()
                                .aspectRatio(2.5/3.5, contentMode: .fit)
                                .scaleEffect(card.isSelected ? 1.08 : 1)
                                
                                .shadow(color: Color.black.opacity(0.2), radius: card.isSelected ? 15 : 5, x: card.isSelected ? -1:0, y: card.isSelected ? -1:0)
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        game.chooseCard(card: card)
                                    }
                                    
                                }
                            
                        }
                        
                    }.padding()
                }
                )
                
            }
        }
    }
    
    var Decks: some View {
        HStack{
            ZStack{
                ZStack {
                    ForEach(game.deck) { card in
                        CardView(card: card)
                            .aspectRatio(3/4, contentMode: .fit)
                            .frame(width: 75, height: 120, alignment: .center)
                        
                    }
                }
                
                Image("backOfCard")
                    .resizable()
                    .aspectRatio(3/4, contentMode: .fit)
                    .frame(width: 80, height: 120, alignment: .center)
                    .scaleEffect(isTapped ? 1.1 : 1)
                    .animation(.spring(response: 0.4, dampingFraction: 0.6))
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            game.dealCards()
                            isTapped.toggle()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            isTapped = false
                        }
                    }.opacity(game.deckCount > 0 ? 1 : 0 ) // When deck is empty set opacity to 0
            }
            ZStack {
                RoundedRectangle(
                    cornerRadius: 10,
                    style: .continuous
                )
                .fill(Color.gray.opacity(0.1))
                .aspectRatio(3/4, contentMode: .fit)
                .frame(width: 75, height: 120, alignment: .center)
                
                
                
                ForEach(game.discardPile.prefix(3)) { card in
                    CardView(card: card)
                        .aspectRatio(3/4, contentMode: .fit)
                        .frame(width: 75, height: 120, alignment: .center)
                        .offset(x: CGFloat(Int.random(in: -5..<5)), y: CGFloat(Int.random(in: -5..<5)))
                }
            }
        }.padding(.horizontal)
    }
}


struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(game: SetGame(cards: SetCardContent.generateAll()))
    }
}


