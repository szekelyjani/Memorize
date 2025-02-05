//
//  EmojiMemoryThemeChooser.swift
//  Memorize
//
//  Created by Szekely Janos on 2025. 01. 26..
//

import SwiftUI

struct EmojiMemoryThemeChooser: View {
    @EnvironmentObject var store: EmojiMemoryThemeStore
    @State private var showEditor = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink {
                        EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme))
                    } label: {
                        if let index = store.themes.firstIndex(of: theme) {
                            ThemeChooserRowView(theme: $store.themes[index])
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            showEditor.toggle()
                        } label: {
                            Image(systemName: "info.circle.fill")
                        }
                        .tint(.blue)
                    }
                    .sheet(isPresented: $showEditor) {
                        EmojiMemoryThemeEditor(theme: theme)
                    }
                }
                .onDelete { indexSet in
                    withAnimation {
                        store.themes.remove(atOffsets: indexSet)
                    }
                }

            }
            .navigationTitle("MemoryGame")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        store.addNewTheme()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    EmojiMemoryThemeChooser()
        .environmentObject(EmojiMemoryThemeStore(named: "Preview"))
}
