//
//  SliderView.swift
//  Slider
//
//  Created by Lidor Fadida on 23/12/2024.
//

import Shapes
import SwiftUI

public struct SliderView: View {
    @Binding var sliderValue: CGFloat
    var minValue: CGFloat
    var maxValue: CGFloat
    var knobColor: Color
    var knobRadius: CGFloat
    var trackColor: Color
    var trackLineWidth: CGFloat
    
    @State private var angleValue: CGFloat = 0.0
    @State private var isDragging: Bool = false
    
    private var trackFromTrimValue: CGFloat {
        angleValue / 180.0
    }
    
    public init(
        sliderValue: Binding<CGFloat>,
        minValue: CGFloat = 0.0,
        maxValue: CGFloat = 180.0,
        knobColor: Color = .red,
        knobRadius: CGFloat = 25.0,
        trackColor: Color = .yellow,
        trackLineWidth: CGFloat = 45.0
    ) {
        precondition(minValue < maxValue)
        self._sliderValue = sliderValue
        self.minValue = minValue
        self.maxValue = maxValue
        self.knobColor = knobColor
        self.knobRadius = knobRadius
        self.trackColor = trackColor
        self.trackLineWidth = trackLineWidth
    }

    private struct Constants {
        static let startAngle: CGFloat = 180.0
        static let endAngle: CGFloat = 360.0
        static let knobStartAngle: CGFloat = 30.0
        static let knobEndAngle: CGFloat = 150.0
    }
    
    public var body: some View {
        GeometryReader { proxy in
            let radius = proxy.size.width - trackLineWidth
            ZStack(alignment: .leading) {
                arcTracks(radius: radius)
                knob(width: proxy.size.width)
            }
            .frame(width: radius, height: proxy.size.height)
            .onAppear(perform: onAppear)
            .onChange(of: sliderValue) { newValue in
                guard !isDragging else { return }
                withAnimation(.spring(duration: 0.5, bounce: 0.2)) {
                    angleValue = angle(for: newValue)
                }
            }
        }
    }
    
    private func arcTracks(radius: CGFloat) -> some View {
        ZStack {
            TrackArcShape(startAngle: .degrees(Constants.startAngle),
                 endAngle: .init(degrees: Constants.endAngle),
                clockwise: false)
            .stroke(
                Color.black.shadow(
                    .inner(color: .white, radius: 3.0)
                ),
                lineWidth: trackLineWidth
            )
            .frame(width: radius, height: radius)
            
            TrackArcShape(startAngle: .degrees(360.0),
                endAngle: .degrees(180.0),
                clockwise: true)
            .trim(from: trackFromTrimValue, to: 1.0)
            .stroke(trackColor.gradient, lineWidth: trackLineWidth)
            .frame(width: radius, height: radius)
        }
    }
    
    @ViewBuilder
    private func knob(width: CGFloat) -> some View {
        let knobSize = knobRadius * 2
        Circle()
            .fill(knobColor)
            .frame(width: knobSize, height: knobSize)
            .offset(
                y: -(width / 2.0) + (trackLineWidth / 2.0)
            )
            .rotationEffect(Angle.degrees(angleValue))
            .gesture(
                DragGesture(minimumDistance: 0.0).onChanged(onChange).onEnded { _ in isDragging = false }
            )
            .shadow(radius: 4.0)
            .offset(x: -knobRadius)
    }
    
    ///onAppear
    private func onAppear() {
        let clampedProgress = min(max(sliderValue, minValue), maxValue)
        sliderValue = clampedProgress
        var newAngle = angle(for: clampedProgress)
        newAngle = min(max(newAngle, Constants.knobStartAngle), Constants.knobEndAngle)
        angleValue = newAngle
    }
    
    ///DragGesture did change
    private func onChange(_ dragGesture: DragGesture.Value) {
        self.isDragging = true
        let location = dragGesture.location
        let vector = CGVector(dx: location.x, dy: location.y)

        let angleInRadians = atan2(vector.dy - knobRadius,
                                   vector.dx - knobRadius) + .pi / 2.0

        let angleInDegrees = min(
            max(angleInRadians.degrees, Constants.knobStartAngle),
            Constants.knobEndAngle
        )
        let newValue = progress(for: angleInDegrees)
        let clampedProgress = min(max(newValue, minValue), maxValue)
        withAnimation(.spring(duration: 0.2, bounce: 0.5)) {
            sliderValue = clampedProgress
            angleValue = angle(for: clampedProgress)
        }
    }
    
    ///Transforms degrees to progress
    private func progress(for degrees: CGFloat) -> CGFloat {
        let fraction = 1.0 - ((degrees - Constants.knobStartAngle) / (Constants.knobEndAngle - Constants.knobStartAngle))
        return fraction * (maxValue - minValue) + minValue
    }
    
    ///Transforms progress to degrees
    private func angle(for progress: CGFloat) -> CGFloat {
        let fraction = (progress - minValue) / (maxValue - minValue)
        return Constants.knobEndAngle - fraction * (Constants.knobEndAngle - Constants.knobStartAngle)
    }
}

///File private extension
fileprivate extension CGFloat {
    var degrees: Self {
        return self * 180.0 / .pi
    }
}
