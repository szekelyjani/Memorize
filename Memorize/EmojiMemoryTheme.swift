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
        EmojiMemoryTheme(name: "Animals", emoji: ["🐶","🐯","🐱","🐭","🦊","🐻","🐼","🐷","🐨","🐵","🦁", "🐔"], colorRGB: UIColor.blue.rgb, numberOfPairs: 8),
        EmojiMemoryTheme(name: "Halloween", emoji: ["👻","🎃","🧟","🕷","🕸", "🦇", "🪓", "🔪", "⛓", "⚰️"], colorRGB: UIColor.orange.rgb, numberOfPairs: 6),
        EmojiMemoryTheme(name: "Suites", emoji: ["♠️","♣️","♥️","♦️"], colorRGB: UIColor.gray.rgb, numberOfPairs: 4),
        EmojiMemoryTheme(name: "Sport", emoji: ["⚽️","🏀","🏈","⚾️","🎾","🏐","🎱", "🏉", "🏓", "🥎", "🥇", "🏆"], colorRGB: UIColor.red.rgb, numberOfPairs: 6),
        EmojiMemoryTheme(name: "Food", emoji: ["🍏","🍎","🍊","🍋","🍌","🥑","🥝","🍇","🍐","🍓","🍒","🍉"], colorRGB: UIColor.blue.rgb, numberOfPairs: 8),
        EmojiMemoryTheme(name: "Vehicles", emoji: ["🚕","🚌","🚓","🚑","🚒","🚜","🚚","🚛","🚠","🚋","🚄","✈️","🛳","🚁","🚂"], colorRGB: UIColor.purple.rgb, numberOfPairs: 5),
        EmojiMemoryTheme(name: "Faces", emoji: ["😃","😂","😍","🙃","😇","😎","🤓","🤩",
                                                "🤬","🥶","🤢","🤠","😷","🤕","😱","😜",
                                                "🥵","🤡","💩","🥳"],
                         colorRGB: UIColor.systemPink.rgb, numberOfPairs: 7),
    ]

    static let template = EmojiMemoryTheme(name: "Preview Theme", emoji: ["😃", "👍🏻", "🌈", "❤️"], colorRGB: UIColor.systemGreen.rgb, numberOfPairs: 4)
}
