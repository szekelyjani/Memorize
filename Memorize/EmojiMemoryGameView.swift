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
        NavigationStack {
            VStack {
                if !viewModel.gameOver && dealt.isEmpty {
                    Spacer().frame(height: 100)
                    startGame
                }
                
                if viewModel.gameOver {
                    Spacer().frame(height: 100)
                    gameOver
                    Spacer()
                }
                
                if !viewModel.gameOver {
                    cards
                }
                
                HStack {
                    score
                    Spacer()
                    deck
                    Spacer()
                    restartButton
                }
                .font(.title)
            }
            .padding()
            .navigationTitle(viewModel.theme.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    shuffleButton
                }
            }
        }
        .tint(viewModel.theme.color)
    }
    
    private var startGame: some View {
        Text("Tap on the deck to start the game!")
            .font(.system(size: 40))
            .foregroundStyle(viewModel.theme.color)
            .multilineTextAlignment(.center)
    }
    
    private var gameOver: some View {
        VStack(alignment: .center, spacing: 32) {
            Group {
                Text("Game Over")
                Text("Your final score is: \(viewModel.score)")
            }
            .foregroundStyle(viewModel.theme.color)
            Button() {
                withAnimation {
                    dealt.removeAll()
                    viewModel.restart()
                }
            } label: {
                Text("Restart")
            }
            .buttonStyle(.borderedProminent)
        }
        .font(.largeTitle)
    }
    
    private var restartButton: some View {
        Button {
            withAnimation {
                dealt.removeAll()
                viewModel.restart()
            }
        } label: {
            Text("New Game")
        }
    }
    
    private var shuffleButton: some View {
        Button {
            withAnimation {
                viewModel.shuffle()
            }
        } label: {
            Image(systemName: "shuffle")
        }
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
            .foregroundStyle(viewModel.theme.color)
    }

    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(spacing)
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
