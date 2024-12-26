//
//  UIFont+Extensions.swift
//  SmartLight
//
//  Created by Lidor Fadida on 24/12/2024.
//

import UIKit

public enum DancingScriptFont: String, CaseIterable {
    case regular = "Regular"
    case medium = "Medium"
    case bold = "Bold"
    
    static var descriptor: String { "DancingScript" }
}

public enum JosefinSansFont: String, CaseIterable {
    case regular = "Regular"
    case bold = "Bold"
    
    static var descriptor: String { "JosefinSans" }
}

public extension UIFont {
    
    static func dancingScript(weight: DancingScriptFont, _ size: CGFloat) -> UIFont {
        let fontName = "\(DancingScriptFont.descriptor)-\(weight.rawValue)"
        guard let font = UIFont(name: fontName, size: size) else {
            return .systemFont(ofSize: size)
        }
        return font
    }
    
    static func josefinSans(weight: JosefinSansFont, _ size: CGFloat) -> UIFont {
        let fontName = "\(JosefinSansFont.descriptor)-\(weight.rawValue)"
        guard let font = UIFont(name: fontName, size: size) else {
            return .systemFont(ofSize: size)
        }
        return font
    }

    static func registerCustomFonts() {
        registerDancingScriptFont()
        registerJosefinSansFont()
    }
    
    private static func registerDancingScriptFont() {
        let sanFransiscoWeights = DancingScriptFont.allCases
        let descriptor = DancingScriptFont.descriptor
        sanFransiscoWeights
            .map { $0.rawValue }
            .forEach { fontWeight in
                registerFont(forResource: "\(descriptor)-\(fontWeight)", ofType: "ttf")
            }
    }
    
    private static func registerJosefinSansFont() {
        let sanFransiscoWeights = JosefinSansFont.allCases
        let descriptor = JosefinSansFont.descriptor
        sanFransiscoWeights
            .map { $0.rawValue }
            .forEach { fontWeight in
                registerFont(forResource: "\(descriptor)-\(fontWeight)", ofType: "ttf")
            }
    }
    
    @discardableResult
    private static func registerFont(forResource: String, ofType: String) -> Bool {
        guard let fontPath = Bundle.module.path(forResource: forResource, ofType: ofType) else { return false }
        guard let fontData = NSData(contentsOfFile: fontPath) else { return false }
        guard let fontDataProvider = CGDataProvider(data: fontData) else { return false }
        guard let customFont = CGFont(fontDataProvider) else { return false }
        
        return CTFontManagerRegisterGraphicsFont(customFont, nil)
    }
}

