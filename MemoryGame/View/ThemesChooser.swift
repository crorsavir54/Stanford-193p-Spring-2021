//
//  ThemesChooser.swift
//  MemoryGame
//
//  Created by coriv🧑🏻‍💻 on 9/6/21.
//

import SwiftUI

struct ThemesChooser: View {
    
    @EnvironmentObject var gameThemes: ThemeChooser
    @Environment(\.presentationMode) var presentationMode
    @State var editMode: EditMode = .inactive
    @State var selectedTheme = Theme(name: "", emojis: "", cardsNumber: 0, color: UIColor.getRGB(.lightGray))
    @State var unchangedSelectedTheme = Theme(name: "", emojis: "", cardsNumber: 0, color: UIColor.getRGB(.lightGray))
    
    //Sheets for editing and adding a theme
    @State var isThemeEditorPresented = false
    @State var isAddThemePresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(gameThemes.themes) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(game: EmojiMemoryGame(theme: theme))) {
                        HStack {
                            ThemeRow(theme: theme)
                            if (editMode == .active) {
                                Spacer()
                                Button(action: {
                                    isThemeEditorPresented = true
                                    selectedTheme = theme
                                    unchangedSelectedTheme = selectedTheme
                                    withAnimation() {
                                        gameThemes.removeTheme(theme)
                                    }
                                    
                                }, label: {
                                    Image(systemName: "pencil")
                                })
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { gameThemes.themes[$0] }.forEach { theme in
                        gameThemes.removeTheme(theme)
                    }
                }
            }
            .navigationTitle("Memorize")
            .toolbar{
                ToolbarItem{EditButton()}
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        isThemeEditorPresented = true
                        selectedTheme = Theme(name: "", emojis: "", cardsNumber: 0, color: UIColor.getRGB(.white))
                        unchangedSelectedTheme = selectedTheme
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .sheet(isPresented: $isAddThemePresented){
                ThemeEditor(themeToAdd: $selectedTheme)
            }
            .sheet(isPresented: $isThemeEditorPresented, onDismiss: didDismiss) {
                ThemeEditor(themeToAdd: $selectedTheme)
            }
            
            .environment(\.editMode, $editMode)
        }
        
    }
    // MARK: TODO - Add a done and cancel button
    // Automatically save sheet info on dismiss...
    func didDismiss() {
        withAnimation(){
            if !(selectedTheme.name == "")||(selectedTheme.emojis.count > 0) {
                gameThemes.insertTheme(theme: selectedTheme)
                if selectedTheme.name != unchangedSelectedTheme.name {
                    gameThemes.removeTheme(unchangedSelectedTheme)
                }
            }
            
        }
    }
}
//struct ThemesChooser_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemesChooser(gameThemes: ThemeChooser(named: "Default"), selectedTheme: Theme(name: "Vehicles", emojis: "🚙🚗🚘🚕🚖🏎🚚🛻🚛🚐🚓🚔🚑🚒🚀✈️🛫🛬🛩🚁🛸🚲🏍🛶⛵️🚤", cardsNumber: 8, color: .init(red: 100/255, green: 200/255, blue: 200/255, alpha: 1)))
//    }
//}
