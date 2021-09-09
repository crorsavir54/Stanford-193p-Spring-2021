//
//  ThemeRow.swift
//  MemoryGame
//
//  Created by coriv🧑🏻‍💻 on 9/6/21.
//

import SwiftUI

struct ThemeRow: View {
    var theme: Theme
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                    Text("\(theme.name)")
                        .foregroundColor(Color(theme.color))
                        .font(.title2)
                if(theme.cardsNumber < theme.emojis.count) {
                    Text("\(theme.cardsNumber) pairs from: \(theme.emojis)")
                        .lineLimit(1)
                }else {
                    Text("All of \(theme.emojis)")
                        .lineLimit(1)
                }

            }
        }
    }
}

//struct ThemeRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeRow(theme: (Theme.vehicles))
//    }
//}
