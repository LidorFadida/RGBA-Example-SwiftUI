//
//  SmartLightViewProperties.swift
//  SmartLight
//
//  Created by Lidor Fadida on 24/12/2024.
//

import Foundation

public struct SmartLightViewProperties {
    init() {}
    
    static var channelRange: ClosedRange<CGFloat> = (0.0...255.0)
    
    /// Enum representing the different color channels.
    public enum ColorChannel: String, CaseIterable, Identifiable {
        case red = "R"
        case green = "G"
        case blue = "B"
        case alpha = "A"
        
        ///Identifiable as self for simplicity.
        public var id: ColorChannel { self }
    }

}

