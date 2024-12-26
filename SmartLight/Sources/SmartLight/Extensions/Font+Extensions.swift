//
//  Font+Extensions.swift
//  SmartLight
//
//  Created by Lidor Fadida on 24/12/2024.
//

import SwiftUI

extension Font {
    
    static func from(uiFont: UIFont) -> Font {
        return Font(uiFont as CTFont)
    }
}
