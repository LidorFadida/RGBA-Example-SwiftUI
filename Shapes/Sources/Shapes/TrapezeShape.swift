//
//  TrapezeShape.swift
//  Shapes
//
//  Created by Lidor Fadida on 23/12/2024.
//

import SwiftUI

public struct TrapezeShape: Shape {
    public let baseWidth: CGFloat
    
    public init(baseWidth: CGFloat) {
        self.baseWidth = baseWidth
    }
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.minX - baseWidth, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX + baseWidth, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: .zero))
        path.addLine(to: CGPoint(x: rect.minX + baseWidth , y: .zero))
        return Path(path.cgPath)
    }
}
