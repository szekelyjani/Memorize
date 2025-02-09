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
    @State var selectedTheme: EmojiMemoryTheme?
    
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
                            selectedTheme = theme
                        } label: {
                            Image(systemName: "info.circle.fill")
                        }
                        .tint(.blue)
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
            .sheet(item: $selectedTheme) { theme in
                if let index = store.themes.firstIndex(of: theme) {
                    EmojiMemoryThemeEditor(theme: $store.themes[index])
                }
            }
        }
    }
}

#Preview {
    EmojiMemoryThemeChooser()
        .environmentObject(EmojiMemoryThemeStore(named: "Preview"))
}
