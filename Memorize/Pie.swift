//
//  Pie.swift
//  Memorize
//
//  Created by Szekely Janos on 2025. 01. 18..
//

import CoreGraphics
import SwiftUI

struct Pie: Shape {
    var startAngle: Angle = .zero
    let endAngle: Angle
    let clockWise: Bool = true
    
    func path(in rect: CGRect) -> Path {
        let startAngle = startAngle - .degrees(90)
        let endAngle = endAngle - .degrees(90)
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.y + radius * sin(startAngle.radians)
        )
        
        var path = Path()
        path.move(to: center)
        path.addLine(to: start)
        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockWise
        )
        path.addLine(to: center)
        return path
    }
    
}
