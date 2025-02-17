//
//  ThemeChooserRowView.swift
//  Memorize
//
//  Created by Szekely Janos on 2025. 01. 26..
//

import SwiftUI

struct ThemeChooserRowView: View {
    @Binding var theme: EmojiMemoryTheme
    var body: some View {
        VStack(alignment: .leading) {
            Text(theme.name)
                .font(.title)
                .foregroundStyle(theme.color)
            
            Text("\(theme.numberOfPairs == theme.emoji.count ? "All" : "\(theme.numberOfPairs)") of \(theme.emoji.joined())")
                .truncationMode(.tail)
                .lineLimit(1)
        }
    }
}

#Preview {
    struct PreviewView: View {
        @State private var previewTheme = EmojiMemoryTheme.template
        var body: some View {
            ThemeChooserRowView(theme: $previewTheme)
        }
    }
    return PreviewView()
}
