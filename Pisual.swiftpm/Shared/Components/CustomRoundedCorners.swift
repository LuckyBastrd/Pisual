//
//  CustomRoundedCorners.swift
//  Pisual
//
//  Created by Lucky on 17/02/25.
//

import SwiftUI

struct CustomRoundedCorners: Shape {
    var topLeft: CGFloat
    var topRight: CGFloat
    var bottomLeft: CGFloat
    var bottomRight: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX + topLeft, y: rect.minY))
        
        path.addLine(to: CGPoint(x: rect.maxX - topRight, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - topRight, y: rect.minY + topRight),
                    radius: topRight, startAngle: .degrees(270), endAngle: .degrees(0),
                    clockwise: false)
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRight))
        path.addArc(center: CGPoint(x: rect.maxX - bottomRight, y: rect.maxY - bottomRight),
                    radius: bottomRight, startAngle: .degrees(0), endAngle: .degrees(90),
                    clockwise: false)
        
        path.addLine(to: CGPoint(x: rect.minX + bottomLeft, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.minX + bottomLeft, y: rect.maxY - bottomLeft),
                    radius: bottomLeft, startAngle: .degrees(90), endAngle: .degrees(180),
                    clockwise: false)
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeft))
        path.addArc(center: CGPoint(x: rect.minX + topLeft, y: rect.minY + topLeft),
                    radius: topLeft, startAngle: .degrees(180), endAngle: .degrees(270),
                    clockwise: false)

        path.closeSubpath()
        return path
    }
}

extension View {
    func customCornerRadius(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) -> some View {
        self.modifier(CornerRadiusModifier(
            topLeft: topLeft,
            topRight: topRight,
            bottomLeft: bottomLeft,
            bottomRight: bottomRight))
    }
}
