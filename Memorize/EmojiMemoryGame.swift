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
    private(set) var theme: EmojiMemoryTheme
    @Published private var game: MemoryGame<String>
    @Published private(set) var gameOver = false
    
    init(theme: EmojiMemoryTheme? = nil) {
        self.theme = theme ?? EmojiMemoryTheme.themes.randomElement()!
        let emoji = self.theme.emoji.shuffled()
        game = MemoryGame(numberOfPairsOfCards: self.theme.numberOfPairs) { emoji[$0] }
    }
    
    var cards: [Card] { game.cards }
    var score: Int {
        game.score
    }
    
    func choose(_ card: Card) {
        game.choose(card)
        let unMatchedCards = cards.filter({!$0.isMatched})
        gameOver = unMatchedCards.isEmpty
    }
    
    func shuffle() {
        game.shuffle()
    }
    
    func restart() {
        let emoji = theme.emoji.shuffled()
        let numberOfPairs = theme.numberOfPairs
        game = MemoryGame(numberOfPairsOfCards: numberOfPairs) { emoji[$0] }
        gameOver = false
    }
}
