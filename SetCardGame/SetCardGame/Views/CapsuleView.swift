//
//  CapsuleShapeView.swift
//  SetCardGame
//
//  Created by coriv on 8/20/21.
//

import SwiftUI

struct CapsuleView: View {
    var shade: String = "solid"
    var color: Color = .pink
    var body: some View {
        
        if shade == "solid" {
            Capsule()
                .fill(color).opacity(1)
        }
        if shade == "stripe" {
            Capsule()
                .strokeBorder(color, lineWidth: 2)
                .background(Capsule().fill(color.opacity(0.3)))
        }
        if shade == "none" {
            Capsule()
                .strokeBorder(color,lineWidth: 2)
        }
    }
}
