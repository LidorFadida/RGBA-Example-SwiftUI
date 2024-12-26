//
//  TrackArcShape.swift
//  Shapes
//
//  Created by Lidor Fadida on 23/12/2024.
//

import SwiftUI

///Implementation sets the center to CGPoint(x: rect.minX, y: rect.midY) and the radius to width / 2.0  to get the half circle effect.
public struct TrackArcShape: Shape {
    private let startAngle: Angle
    private let endAngle: Angle
    private let clockwise: Bool

    public init(startAngle: Angle, endAngle: Angle, clockwise: Bool) {
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.clockwise = clockwise
    }
    
    public func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.minX, y: rect.midY),
            radius: rect.width / 2,
            startAngle: modifiedStart,
            endAngle: modifiedEnd,
            clockwise: !clockwise
        )

        return path
    }
}
