//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Szekely Janos on 2025. 01. 11..
//

import Foundation
import SwiftUICore

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["👾", "🎃", "☠️", "👻", "🤠", "🫥", "💩", "👽", "💀", "🤖", "🐶","🐹"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 2) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "❌"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: [Card] { model.cards }
    
    var color: Color {
        .orange
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
