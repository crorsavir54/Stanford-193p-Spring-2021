//
//  CardView.swift
//  MemoryGame
//
//  Created by coriv on 8/10/21.
//

import SwiftUI

struct CardView: View {
    var card: MemoryGame<String>.Card
    var themeColor: Color
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    /// ViewBuilder returns EmptyView(), if the condition fails
    @ViewBuilder
    private func body(for size: CGSize) -> some View {  /// Trick to avoid <self> inside GeometryReader or ForEach
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90),
                            endAngle: Angle.degrees(-animatedBonusRemaining * 360 - 90),
                            clockwise: true)
                            .fill(themeColor)
                            .onAppear {
                                startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0 - 90),
                            endAngle: Angle.degrees(-card.bonusRemaining * 360 - 90),
                            clockwise: true)
                            .fill(themeColor)
                    }
                }
                .padding(7)
                .opacity(themeOpacityForPie)

                Text(card.content)
                    .font(.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ?
                                Animation.linear(duration: 1).repeatForever(autoreverses: false)
                                : .default)
            }
            .cardify(isFaceUp: card.isFaceUp, themeColor: themeColor)
            .transition(AnyTransition.scale)
        }
    }
    
    // MARK: - Drawing Constraits
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.65
    }
    private let themeOpacityForPie = 0.3
}
