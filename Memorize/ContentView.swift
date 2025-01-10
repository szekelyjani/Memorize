//
//  ContentView.swift
//  Memorize
//
//  Created by Szekely Janos on 2025. 01. 10..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView()
            CardView()
            CardView()
            CardView()
        }
        .padding()
        .foregroundStyle(.orange)
    }
}

#Preview {
    ContentView()
}
