//
//  Array+Ext.swift
//  Memorize
//
//  Created by Szekely Janos on 2025. 01. 26..
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(of item: Element) -> Int? {
        if let index = self.firstIndex(where: { $0.id == item.id }) {
            return index
        }
        return nil
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
