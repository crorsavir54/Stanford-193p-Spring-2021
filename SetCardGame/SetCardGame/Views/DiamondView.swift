//
//  DiamondView.swift
//  SetCardGame
//
//  Created by coriv on 8/20/21.
//

import SwiftUI
struct Diamond: Shape, InsettableShape {
    var insetAmount: CGFloat = 0
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.closeSubpath()
        return path
        
    }
    func inset(by amount: CGFloat) -> some InsettableShape {
        var diamond = self
        diamond.insetAmount += amount
        return diamond
    }
}
struct DiamondView: View {
    var shade: String = "solid"
    var color: Color
    var body: some View {
        
        if shade == "solid" {
            Diamond()
                .fill(color).opacity(1)
        }
        if shade == "stripe" {
            Diamond()
                .strokeBorder(color, lineWidth: 2)
                .background(Diamond().fill(color.opacity(0.3)))
        }
        if shade == "none" {
            Diamond()
                .strokeBorder(color,lineWidth: 2)
        }
        
        
        
    }
}
