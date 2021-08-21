//
//  SetGameView.swift
//  SetCardGame
//
//  Created by coriv on 8/20/21.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGame
    private let layout = [
        GridItem(.adaptive(minimum: 50)),
        GridItem(.adaptive(minimum: 50)),
        GridItem(.adaptive(minimum: 50)),
        GridItem(.adaptive(minimum: 50))
    ]

    var body: some View {
        
        NavigationView {
            ZStack {
                Color.gray.opacity(0.2)
                   .ignoresSafeArea()
                VStack {
                    ScrollView(content: {
                        LazyVGrid(columns: layout) {
                            ForEach(game.dealtCards) { card in
                                CardView(card: card)
                                    
                                    .onTapGesture {
                                        game.chooseCard(card: card)
                                    }
                            }
                        }
                    })
                }.padding()
            }
            .navigationBarTitle("Set Game", displayMode: .inline)
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        
                        Image("backOfCard")
                            .resizable()
                            .frame(width: 70, height: 100, alignment: .center)
                            .onTapGesture {
                                game.dealCards()
                            }
                            .scaleEffect()
                            .animation(.linear)
                        Spacer()
                        Button(action: {game.reset()}, label: {
                            Text("Reset Game")
                        }).animation(.easeIn)
                    }
                }
        }
    }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(game: SetGame(cards: SetCardContent.generateAll()))
    }
}
