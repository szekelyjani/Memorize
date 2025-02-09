//
//  EmojiMemoryThemeEditor.swift
//  Memorize
//
//  Created by Szekely Janos on 2025. 01. 29..
//

import SwiftUI

struct EmojiMemoryThemeEditor: View {
    enum Focused {
        case name
        case addEmoji
    }
    @Environment(\.dismiss) private var dismiss
    @Binding var theme: EmojiMemoryTheme
    @State private var tempTheme: EmojiMemoryTheme
    @FocusState private var focused: Focused?
    @State var selectedColor: Color
    @State private var emojiToAdd: String = ""
    private let emojiFont = Font.system(size: 40)
    
    init(theme: Binding<EmojiMemoryTheme>) {
        self._tempTheme = State(initialValue: theme.wrappedValue)
        self._theme = theme
        let uiColor = UIColor(
            red: theme.colorRGB.wrappedValue.red,
            green: theme.colorRGB.wrappedValue.green,
            blue: theme.colorRGB.wrappedValue.blue,
            alpha: theme.colorRGB.wrappedValue.alpha
        )
        _selectedColor = State(initialValue: Color(uiColor))
    }
        
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    nameTextField
                    colorPicker
                }
                
                Section("Number of pairs") {
                    numberOfPairsStepper
                }
                
                Section("Emojis") {
                    addEmoji
                    removeEmoji
                }
            }
            .navigationTitle(theme.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        save()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role:.cancel) { dismiss() }
                }
            }
        }
    }
    
    private var nameTextField: some View {
        TextField("Name:", text: $tempTheme.name)
            .focused($focused, equals: .name)
    }
    
    private var colorPicker: some View {
        ColorPicker("Select Color", selection: $selectedColor)
            .pickerStyle(.menu)
    }
    
    private var numberOfPairsStepper: some View {
        Stepper("\(tempTheme.numberOfPairs) pairs", value: $tempTheme.numberOfPairs, in: 2...tempTheme.emoji.count)
    }
    
    private var addEmoji: some View {
        TextField("Add Emojis Here", text: $emojiToAdd)
            .focused($focused, equals: .addEmoji)
            .font(emojiFont)
            .onChange(of: emojiToAdd) { _, newValue in
                if !tempTheme.emoji.contains(newValue) {
                    tempTheme.emoji.append(newValue)
                }
            }
    }
    
    private var removeEmoji: some View {
        VStack(alignment: .trailing) {
            Text("Tap to Remove Emojis").font(.caption).foregroundStyle(.secondary)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(theme.emoji, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                if let index = tempTheme.emoji.firstIndex(of: emoji), tempTheme.emoji.count > 2 {
                                    tempTheme.emoji.remove(at: index)
                                    tempTheme.numberOfPairs = theme.emoji.count
                                }
                            }
                        }
                }
            }
        }
        .font(emojiFont)
    }
    
    private func save() {
        theme.colorRGB = selectedColor.toRGB()
        theme.emoji = tempTheme.emoji
        theme.numberOfPairs = tempTheme.numberOfPairs
        theme.name = tempTheme.name
        dismiss()
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
