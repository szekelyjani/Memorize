//
//  CardView.swift
//  Memorize
//
//  Created by Szekely Janos on 2025. 01. 10..
//

import SwiftUI

struct CardView: View {
    @State var isFaceUp: Bool = false
    
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 12)
        
        ZStack {
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text("🤯")
            } else {
                base
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    CardView()
}
