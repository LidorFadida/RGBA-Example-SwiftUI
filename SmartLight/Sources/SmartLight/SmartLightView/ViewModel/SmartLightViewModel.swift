//
//  SmartLightViewModel.swift
//  SmartLight
//
//  Created by Lidor Fadida on 24/12/2024.
//

import SwiftUI

public class SmartLightViewModel: SmartLightViewModelProtocol {
    @MainActor @Published public private(set) var selectedChannel: SmartLightViewProperties.ColorChannel
    @MainActor @Published public private(set) var red: CGFloat
    @MainActor @Published public private(set) var green: CGFloat
    @MainActor @Published public private(set) var blue: CGFloat
    @MainActor @Published public private(set) var alpha: CGFloat
    @MainActor @Published public private(set) var lampAnimationOffset: CGFloat
    @MainActor public var binding: Binding<CGFloat> {
        Binding(
            get: {
                switch self.selectedChannel {
                case .red: return self.red
                case .green: return self.green
                case .blue: return self.blue
                case .alpha: return self.alpha
                }
            },
            set: { newValue in
                switch self.selectedChannel {
                case .red: self.red = newValue
                case .green: self.green = newValue
                case .blue: self.blue = newValue
                case .alpha: self.alpha = newValue
                }
            }
        )
    }
    
    @MainActor
    public var selectedColor: Color {
        let threshold = SmartLightViewProperties.channelRange.upperBound
        return Color(
            red: red / threshold,
            green: green / threshold,
            blue: blue / threshold,
            opacity: max(0.4, alpha / threshold)
        )
    }
    
    @MainActor
    public required init(
        selectedChannel: SmartLightViewProperties.ColorChannel,
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat,
        alpha: CGFloat,
        lampAnimationOffset: CGFloat
    ) {
        let channelsRange = SmartLightViewProperties.channelRange
        self.selectedChannel = selectedChannel
        precondition(channelsRange.contains(red))
        self.red = red
        precondition(channelsRange.contains(green))
        self.green = green
        precondition(channelsRange.contains(blue))
        self.blue = blue
        precondition(channelsRange.contains(alpha))
        self.alpha = alpha
        self.lampAnimationOffset = lampAnimationOffset
    }
    
    @MainActor
    public func pickerColor(channel: SmartLightViewProperties.ColorChannel) -> Color {
        return switch channel {
        case .red: .red
        case .green: .green
        case .blue: .blue
        case .alpha: .white
        }
    }
    
    @MainActor
    public func pickerItemTapped(channel: SmartLightViewProperties.ColorChannel) {
        guard channel != selectedChannel else { return }
        withAnimation(.easeOut(duration: 0.3)) { [weak self] in
            self?.selectedChannel = channel
        }
        
        let lampAnimationDuration: TimeInterval = 0.2
        withAnimation(.easeIn(duration: lampAnimationDuration)) { [weak self] in
            self?.lampAnimationOffset = 5.0
        }
        withAnimation(.easeOut(duration: lampAnimationDuration).delay(lampAnimationDuration)) { [weak self] in
            self?.lampAnimationOffset = .zero
        }
    }
}
