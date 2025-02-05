//
//  EmojiMemoryThemeStore.swift
//  Memorize
//
//  Created by Szekely Janos on 2025. 01. 26..
//

import SwiftUI

class EmojiMemoryThemeStore: ObservableObject {
    let name: String
    private var userDefaultsKey: String {
        "EmojiMemoryThemeStoreKey:" + name
    }
    
    var themes: [EmojiMemoryTheme] {
        get {
            UserDefaults.standard.themes(forKey: userDefaultsKey)
        }
        set {
            if !newValue.isEmpty {
                UserDefaults.standard.set(try? JSONEncoder().encode(newValue), forKey: userDefaultsKey)
                objectWillChange.send()
            }
        }
    }
    
    init(named name: String) {
        self.name = name
        if themes.isEmpty {
            themes = EmojiMemoryTheme.themes
            if themes.isEmpty {
                themes = [EmojiMemoryTheme(name: "Warning", emoji: ["⚠️"], colorRGB: UIColor.RGB.init(red: 1, green: 1, blue: 1, alpha: 1), numberOfPairs: 1)]
            }
        }
    }
    
    func updateTheme(for theme: EmojiMemoryTheme, name: String, emoji: [String], colorRGB: UIColor.RGB, numberOfPairs: Int) {
        let newTheme = EmojiMemoryTheme(name: name, emoji: emoji, colorRGB: colorRGB, numberOfPairs: numberOfPairs)
        if let index = themes.firstIndex(of: theme) {
            themes[index] = newTheme
        }
    }
    
    func addNewTheme() {
        themes.append(EmojiMemoryTheme.template)
    }
    
//    func remove(_ theme: EmojiMemoryTheme) {
//        if let index = themes.firstIndex(of: theme) {
//            themes.remove(at: index)
//        }
//    }
}
