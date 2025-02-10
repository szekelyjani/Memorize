//
//  EmojiMemoryTheme.swift
//  Memorize
//
//  Created by Szekely Janos on 2025. 01. 26..
//

import Foundation
import SwiftUI

struct EmojiMemoryTheme: Codable, Identifiable {
    var id: String { name }
    var name: String
    var emoji: [String]
    var colorRGB: UIColor.RGB
    var numberOfPairs: Int
    
    var color: Color {
        Color(colorRGB)
    }
    
    var json: Data? {
        try? JSONEncoder().encode(self)
    }
    
    init(name: String, emoji: [String], colorRGB: UIColor.RGB, numberOfPairs: Int) {
        self.name = name
        self.emoji = emoji
        self.colorRGB = colorRGB
        self.numberOfPairs = numberOfPairs
    }
    
    init?(json: Data?) {
        if let json, let newEmojiTheme = try? JSONDecoder().decode(EmojiMemoryTheme.self, from: json) {
            self = newEmojiTheme
        } else {
            return nil
        }
    }
    
    static var themes: [EmojiMemoryTheme] = [
        EmojiMemoryTheme(name: "Animals",
                         emoji: ["🐶","🐯","🐱","🐭","🦊","🐻","🐼","🐷","🐨","🐵","🦁", "🐔"],
                         colorRGB: UIColor.systemBlue.rgb,
                         numberOfPairs: 8),
        EmojiMemoryTheme(name: "Halloween",
                         emoji: ["👻","🎃","🧟","🕷","🕸", "🦇", "🪓", "🔪", "⛓", "⚰️"],
                         colorRGB: UIColor.systemOrange.rgb,
                         numberOfPairs: 6),
        EmojiMemoryTheme(name: "Suites",
                         emoji: ["♠️","♣️","♥️","♦️"],
                         colorRGB: UIColor.systemGray.rgb,
                         numberOfPairs: 4),
        EmojiMemoryTheme(name: "Sport",
                         emoji: ["⚽️","🏀","🏈","⚾️","🎾","🏐","🎱", "🏉", "🏓", "🥎", "🥌"],
                         colorRGB: UIColor.systemBrown.rgb,
                         numberOfPairs: 6),
        EmojiMemoryTheme(name: "Fruits",
                         emoji: ["🍏","🍎","🍊","🍋","🍌","🥑","🥝","🍇","🍐","🍓","🍒","🍉"],
                         colorRGB: UIColor.systemRed.rgb,
                         numberOfPairs: 8),
        EmojiMemoryTheme(name: "Vegetables",
                         emoji: ["🍆","🥦","🫛","🥕","🫑","🥬","🍅","🥔","🍠","🌶️"],
                         colorRGB: UIColor.systemGreen.rgb,
                         numberOfPairs: 8),
        EmojiMemoryTheme(name: "Vehicles",
                         emoji: ["🚕","🚌","🚓","🚑","🚒","🚜","🚚","🚛","🚠","🚋","🚄","✈️","🛳","🚁","🚂"],
                         colorRGB: UIColor.systemPink.rgb,
                         numberOfPairs: 5),
        EmojiMemoryTheme(name: "Astrology",
                         emoji: ["♋️","♊️","♈️","♎️","♌️","♒️","♓️","♑️","♐️","♏️","♍️","♉️"],
                         colorRGB: UIColor.systemPurple.rgb,
                         numberOfPairs: 5),
        EmojiMemoryTheme(name: "Faces",
                         emoji: ["😃","😂","😍","🙃","😇","😎","🤓","🤩","🤬","🥶","🤢","🤠","😷","🤕","😱","😜","🥵","🤡","💩","🥳"],
                         colorRGB: UIColor.systemYellow.rgb,
                         numberOfPairs: 7),
    ]

    static let template = EmojiMemoryTheme(name: "Preview Theme",
                                           emoji: ["😃", "👍🏻", "🌈", "❤️"],
                                           colorRGB: UIColor.systemCyan.rgb,
                                           numberOfPairs: 4)
}
