//
//  LampShape.swift
//  Shapes
//
//  Created by Lidor Fadida on 23/12/2024.
//

import SwiftUI

public struct LampShape: Shape {
    public let topBaseWidth: CGFloat
    
    public init(topBaseWidth: CGFloat) {
        self.topBaseWidth = topBaseWidth
    }
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        let startingPoint = CGPoint(x: rect.midX - topBaseWidth, y: rect.minY)
        
        path.move(to: startingPoint)
        path.addCurve(
            to: CGPoint(x: rect.minX, y: rect.maxY),
            controlPoint1: CGPoint(x: rect.maxX * 0.5, y: rect.midY),
            controlPoint2: CGPoint(x: rect.minX, y: rect.maxY * 0.3)
        )
        
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.maxY),
            controlPoint: CGPoint(x: rect.midX, y: rect.maxY * 0.95)
        )
        path.addCurve(
            to: CGPoint(x: rect.midX + topBaseWidth, y: rect.minY),
            controlPoint1: CGPoint(x: rect.maxX, y: rect.maxY * 0.3),
            controlPoint2: CGPoint(x: rect.maxX * 0.5, y: rect.midY)
        )
        path.addLine(to: startingPoint)
        return Path(path.cgPath)
    }
}
