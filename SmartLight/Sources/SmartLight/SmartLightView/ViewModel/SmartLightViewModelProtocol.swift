//
//  SmartLightViewModelProtocol.swift
//  SmartLight
//
//  Created by Lidor Fadida on 24/12/2024.
//

import SwiftUI

public protocol SmartLightViewModelProtocol: ObservableObject {
    var selectedChannel: SmartLightViewProperties.ColorChannel { get }
    var red: CGFloat { get }
    var green: CGFloat { get }
    var blue: CGFloat { get }
    var alpha: CGFloat { get }
    var lampAnimationOffset: CGFloat { get }
    var binding: Binding<CGFloat> { get }
    var selectedColor: Color { get }
    
    @MainActor
    init(
        selectedChannel: SmartLightViewProperties.ColorChannel,
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat,
        alpha: CGFloat,
        lampAnimationOffset: CGFloat
    )
    
    @MainActor
    func pickerItemTapped(channel: SmartLightViewProperties.ColorChannel)
    
    @MainActor
    func pickerColor(channel: SmartLightViewProperties.ColorChannel) -> Color
}
