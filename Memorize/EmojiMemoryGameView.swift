//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Szekely Janos on 2025. 01. 10..
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    private let dealAnimation: Animation = .easeInOut(duration: 1)
    private let dealInterval: TimeInterval = 0.15
    private let deckWidth: CGFloat = 50
    
    var body: some View {
        VStack {
            cards
                .foregroundStyle(viewModel.color)
            HStack {
                score
                Spacer()
                deck
                    .foregroundStyle(viewModel.color)
                Spacer()
                shuffle
            }
            .font(.title)
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }

    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(spacing)
                    .overlay (FlyingNumber(number: scoreChange(causeBy: card)))
                    .zIndex(scoreChange(causeBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    @Namespace private var dealingNamespace
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture {
            deal()
        }
    }
    
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += dealInterval
        }
    }
    
    private func choose(_ card: Card) {
        withAnimation(.easeInOut(duration: 1)) {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScroreChange = (scoreChange, causeByCardId: card.id)
        }
    }
    
    @State private var lastScroreChange = (0, causeByCardId: "")
    private func scoreChange(causeBy card: Card) -> Int {
        let (amount, id) = lastScroreChange
        return card.id == id ? amount : 0
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
