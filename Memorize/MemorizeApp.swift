//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Szekely Janos on 2025. 01. 10..
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var themeStore = EmojiMemoryThemeStore(named: "Main")
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryThemeChooser()
                .environmentObject(themeStore)
        }
    }
}
