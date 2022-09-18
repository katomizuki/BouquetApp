//
//  CSharp.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/18.
//

import SwiftUI

struct CSharpe: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.width, y: rect.height - 50))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height - 50))
            // adding curve
            
            // total radius of curve
            path.addArc(center: CGPoint(x: rect.width - 40,
                                        y: rect.height - 50),
                        radius: 40,
                        startAngle: .zero,
                        endAngle: .init(degrees: 180),
                        clockwise: false)
        }
    }
}
