//
//  UserDefaults+Ext.swift
//  Memorize
//
//  Created by Szekely Janos on 2025. 01. 26..
//

import Foundation

extension UserDefaults {
    func themes(forKey key: String) -> [EmojiMemoryTheme] {
        if let jsonData = data(forKey: key),
           let decodedThemes = try? JSONDecoder().decode([EmojiMemoryTheme].self, from: jsonData) {
            return decodedThemes
        } else {
            return []
        }
    }
    
    func set(_ themes: [EmojiMemoryTheme], forKey key: String) {
        let data = try? JSONEncoder().encode(themes)
        set(data, forKey: key)
    }
}
