//
//  ThemeEditor.swift
//  MemoryGame
//
//  Created by coriv🧑🏻‍💻 on 9/6/21.
//

import SwiftUI

struct ThemeEditor: View {
    
    @Binding var themeToAdd: Theme
    @State var themeColors: [UIColor] = [.systemBlue, .red, .lightGray, .black, .orange]
    @State var emojisToAdd = ""
    @Environment(\.presentationMode) var presentationMode
    @State var tap = false
    
    var columns: [GridItem] =
            Array(repeating: .init(.flexible()), count: 5)
    
    func addEmojis(_ emojis: String) {
        withAnimation {
            themeToAdd.emojis = (emojis + themeToAdd.emojis)
                .filter{ $0.isEmoji }.removingDuplicateCharacters
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Theme name")) {
                TextField("Name theme", text: $themeToAdd.name)
            }
            Section(header: Text("Emojis"), footer: Text("Tap emoji to exclude")) {
                Grid(themeToAdd.emojis.map{String($0)}, id: \.self) { emoji in
                    Text(emoji)
                        .frame(width: 30, height: 30)
                        .onTapGesture {
                            withAnimation{
                                themeToAdd.emojis = themeToAdd.emojis.replacingOccurrences(of: emoji, with: "")
                            }
                        }
                    //Should have remove array
                    //On tap remove emoji
                }.frame(minHeight: 30, idealHeight: 100, maxHeight: 100)
            }
            Section(header: Text("Add Emoji")) {
                TextField("Emoji", text: $emojisToAdd)
                    .onChange(of: emojisToAdd) { emojis in
                        addEmojis(emojis)
                    }
                
            }
            if themeToAdd.emojis.count > 1 {
                Section(header: Text("Number of cards to play")) {
                    Stepper(value: $themeToAdd.cardsNumber, in: 2...themeToAdd.emojis.count) {
                        Text("\(themeToAdd.cardsNumber) pairs")
                    }
                }
            }
            Section(header: HStack {
                Text("Emoji")
                Circle()
                    .fill(Color(themeToAdd.color))
                    .offset(x: -140, y: 0)
            }
                        
                        
                         ) {
                LazyVGrid(columns: columns) {
                    ForEach(themeColors, id: \.self) { color in
                        Circle()
                            .strokeBorder(Color.gray, lineWidth: 3).brightness(0.4)
                            .background(Circle().fill(Color(color)))
                            .frame(width: 40, height: 40)
                            .clipped()
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 1, y: 2)
                            .animation(.spring())
                            .onTapGesture {
                                withAnimation() {
                                    tap = true
                                    themeToAdd.color = UIColor.getRGB(color)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        tap = false
                                }
                            }
                    }
                    }

                }
//                Grid(themeColors, id: \.self) { color in
//                    Circle()
//                        .strokeBorder(Color.gray, lineWidth: 3).brightness(0.4)
//                        .background(Circle().fill(Color(color)))
//                        .frame(width: 40, height: 40)
//                        .clipped()
//                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 1, y: 2)
//                        .animation(.spring())
//                        .onTapGesture() {
//                            withAnimation(){
//                                tap = true
//                                themeToAdd.color = UIColor.getRGB(color)
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                                    tap = false
//                            }
//                        }
//                }.frame(minHeight: 30, idealHeight: 50, maxHeight: 200)
            }
        }
    }
}


struct ThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditor(themeToAdd: Binding.constant(Theme(name: "Vehicles", emojis: "🚙🚗🚘🚕🚖🏎🚚🛻🚛🚐🚓🚔🚑🚒🚀✈️🛫🛬🛩🚁🛸🚲🏍🛶⛵️🚤", cardsNumber: 8, color: .init(red: 100/255, green: 200/255, blue: 200/255, alpha: 1))))
        }
}

