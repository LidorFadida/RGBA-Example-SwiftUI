//
//  SmartLightAppApp.swift
//  SmartLightApp
//
//  Created by Lidor Fadida on 25/12/2024.
//


import SmartLight
import SwiftUI

@main
struct SmartLightAppApp: App {
    static let viewModel = SmartLightViewModel.init(
        selectedChannel: .red,
        red: 255.0,
        green: 255.0,
        blue: 255.0,
        alpha: 1.0,
        lampAnimationOffset: 5.0
    )
  
    init() { UIFont.registerCustomFonts() }
    
    var body: some Scene {
        WindowGroup {
            SmartLightView(viewModel: Self.viewModel)
                .background(Color.backgroundColor.opacity(0.7))
                .statusBarHidden()
                .persistentSystemOverlays(.hidden)
        }
    }
}
