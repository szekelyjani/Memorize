//
//  Color+Ext.swift
//  Memorize
//
//  Created by Szekely Janos on 2025. 01. 26..
//

import Foundation
import SwiftUI

extension UIColor {
    public struct RGB: Codable, Hashable {
        var red: CGFloat
        var green: CGFloat
        var blue: CGFloat
        var alpha: CGFloat
    }
    
    convenience init(_ rgb: RGB) {
        self.init(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: rgb.alpha)
    }
    
    public var rgb: RGB {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return RGB(red: red, green: green, blue: blue, alpha: alpha)
    }
}


extension Color {
    init(_ rgb: UIColor.RGB) {
        self.init(UIColor(rgb))
    }
    
    func toRGB() -> UIColor.RGB {
            let uiColor = UIColor(self)
            var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
            uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor.RGB(red: red * 255, green: green * 255, blue: blue * 255, alpha: 1)
        }
}
