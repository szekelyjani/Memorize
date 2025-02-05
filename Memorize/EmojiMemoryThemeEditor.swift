//
//  EmojiMemoryThemeEditor.swift
//  Memorize
//
//  Created by Szekely Janos on 2025. 01. 29..
//

import SwiftUI

struct EmojiMemoryThemeEditor: View {
    @Binding var theme: EmojiMemoryTheme
    @State  var selectedColor: Color = .white
        
    var body: some View {
        NavigationStack {
            Form {
                ColorPicker(theme.name, selection: $selectedColor)
                    .pickerStyle(.menu)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .navigationTitle(theme.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    struct PreviewView: View {
        @State private var theme = EmojiMemoryTheme.template
        var body: some View {
            EmojiMemoryThemeEditor(theme: $theme)
        }
    }
    return PreviewView()
}
