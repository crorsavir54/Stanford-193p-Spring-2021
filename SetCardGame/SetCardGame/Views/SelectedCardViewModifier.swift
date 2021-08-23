//
//  SelectedCardViewModifier.swift
//  SetCardGame
//
//  Created by coriv on 8/21/21.
//

import SwiftUI

struct Selected: ViewModifier {
    var selected: Bool
    func body(content: Content) -> some View {
        if selected {
            content
                .offset(x: -2.0, y: -2.0)
//                .shadow(radius: 15, x: 5, y: 5)
        }else {
            content        }
    }
}


extension View {
    func selectedEffect(_ selected: Bool) -> some View {
        self.modifier(Selected(selected: selected))
    }
}
