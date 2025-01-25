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
        return MemoryGame(numberOfPairsOfCards: 12) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "❌"
            }
        }
    }
    
    @Published private var game = createMemoryGame()
    
    var cards: [Card] { game.cards }
    
    var color: Color {
        .orange
    }
    
    var score: Int {
        game.score
    }
    
    func choose(_ card: Card) {
        game.choose(card)
    }
    
    func shuffle() {
        game.shuffle()
    }
    
    func restart() {
        game = EmojiMemoryGame.createMemoryGame()
    }
}
