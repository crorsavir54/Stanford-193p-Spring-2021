//
//  RectangleView.swift
//  SetCardGame
//
//  Created by coriv on 8/20/21.
//

import SwiftUI

struct RectangleView: View {
    var shade: String = "solid"
    var color: Color = .pink
    var body: some View {
        
        if shade == "solid" {
            Rectangle()
                .fill(color).opacity(1)
        }
        if shade == "stripe" {
            Rectangle()
                .strokeBorder(color, lineWidth: 2)
                .background(Rectangle().fill(color.opacity(0.3)))
        }
        if shade == "none" {
            Rectangle()
                .strokeBorder(color,lineWidth: 2)
        }

    }
}
