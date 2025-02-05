//
//  View+Ext.swift
//  Memorize
//
//  Created by Szekely Janos on 2025. 01. 26..
//

import SwiftUI

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
