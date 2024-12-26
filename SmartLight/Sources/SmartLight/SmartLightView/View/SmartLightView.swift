//
//  SmartLightView.swift
//  SmartLight
//
//  Created by Lidor Fadida on 24/12/2024.
//

import Shapes
import Slider
import SwiftUI

public struct SmartLightView<ViewModel: SmartLightViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .center) {
                title
                    .padding(.leading, 24.0)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
                lamp(height: proxy.size.height)
                    .offset(y: viewModel.lampAnimationOffset)
                    .rotationEffect(.degrees(5.0))
                    .frame(width: proxy.size.width * 0.4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .offset(x: -20.0, y: -70.0)
                    .ignoresSafeArea()
                
                slider(proxy: proxy)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .offset(y: -140.0)
                
                colorPicker(
                    width: proxy.size.width * 0.9,
                    itemHeight: proxy.size.height * 0.2,
                    itemSpacing: 20.0
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
    
    private var title: some View {
        HStack(spacing: 4.0) {
            let fontSize: CGFloat = 24.0
            Text("Setup")
                .font(.from(uiFont: .josefinSans(weight: .bold, fontSize)))
            Text("Your")
                .font(.from(uiFont: .josefinSans(weight: .bold, fontSize)))
                .offset(y: fontSize)
            Text("Light")
                .font(.from(uiFont: .dancingScript(weight: .bold, fontSize)))
                .offset(y: fontSize * 2.0)
        }
    }
    
    @ViewBuilder
    private func lamp(height: CGFloat) -> some View {
        let lampHeight = height * 0.2
        VStack(alignment: .center, spacing: .zero) {
            Rectangle()
                .fill(Color.black)
                .frame(width: 3.0, height: lampHeight)
                .layoutPriority(-1)
            LampView(topBaseHeight: 40.0)
                .frame(height: lampHeight)
                .shadow(color: .black.opacity(0.4), radius: 10.0)
            TrapezeShape(baseWidth: 200.0)
                .fill(
                    LinearGradient(
                        colors: [viewModel.selectedColor, viewModel.selectedColor.opacity(0.4), .clear],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .zIndex(-1)
                .offset(y: -4.0)
                .padding(.horizontal, 2.0)
                .shadow(color: viewModel.selectedColor, radius: 10.0, y: 20.0)
        }
    }
    
    private func slider(proxy: GeometryProxy) -> some View {
        VStack(alignment: .leading, spacing: 20.0) {
            let textPadding: CGFloat = 32.0
            Text("HIGH")
                .font(.from(uiFont: .josefinSans(weight: .regular, 22.0)))
                .padding(.leading, textPadding)
            SliderView(
                sliderValue: viewModel.binding,
                minValue: 0.0,
                maxValue: 255.0,
                knobColor: .knobColor,
                trackColor: viewModel.pickerColor(channel: viewModel.selectedChannel)
            )
            .shadow(color: .black.opacity(0.2), radius: 4.0)
            .frame(
                width: proxy.size.width * 0.6,
                height: proxy.size.width * 0.6
            )
            Text("LOW")
                .font(.from(uiFont: .josefinSans(weight: .regular, 22.0)))
                .padding(.leading, textPadding)
        }
    }
 
    @ViewBuilder
    private func colorPicker(
        width: CGFloat,
        itemHeight: CGFloat,
        itemSpacing: CGFloat
    ) -> some View {
        let channels = SmartLightViewProperties.ColorChannel.allCases
        let channelsCount = CGFloat(channels.count)
        let availableWidth = width - (itemSpacing * channelsCount)
        let itemWidth = (availableWidth / channelsCount)
        let itemRadius = 20.0
        HStack(alignment: .bottom, spacing: itemSpacing) {
            ForEach(channels) { channel in
                ZStack {
                    let height = channel == viewModel.selectedChannel ? itemHeight * 1.25 : itemHeight
                    UnevenRoundedRectangle(topLeadingRadius: itemRadius, topTrailingRadius: itemRadius)
                        .fill(viewModel.pickerColor(channel: channel).gradient)
                        .frame(width: itemWidth, height: height)
                        .shadow(radius: .zero)
                        .onTapGesture { viewModel.pickerItemTapped(channel: channel) }
                    Text(channel.rawValue)
                        .font(.from(uiFont: .josefinSans(weight: .bold, 32.0)))
                        .foregroundStyle(Color.black.opacity(0.8))
                        .shadow(color: .white.opacity(0.5), radius: 4.0, y: 4.0)
                        .frame(height: height * 0.7, alignment: .top)
                }
            }
        }
    }
    
    private struct LampView: View {
        var topBaseWidth: CGFloat = 5.0
        var topBaseHeight: CGFloat = 25.0
        
        private var topBaseGradient: some ShapeStyle {
            LinearGradient(
                colors: [Color.lightBrown, Color.mediumBrown, .white],
                startPoint: .trailing,
                endPoint: .leading
            )
        }
        
        private var lampGradient: some ShapeStyle {
            LinearGradient(
                colors: [.black, .black, .backgroundColor],
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
        }
        
        var body: some View {
            VStack(spacing: .zero) {
                UnevenRoundedRectangle(topLeadingRadius: 20.0, topTrailingRadius: 20.0)
                    .fill(topBaseGradient)
                    .frame(width: topBaseWidth * 2.0, height: topBaseHeight)
                LampShape(topBaseWidth: topBaseWidth)
                    .fill(lampGradient)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}


#Preview {
    UIFont.registerCustomFonts()
    
    let viewModel = SmartLightViewModel.init(
        selectedChannel: .blue,
        red: 0.0,
        green: 0.0,
        blue: 255.0,
        alpha: 255.0,
        lampAnimationOffset: 5.0
    )
    return SmartLightView(viewModel: viewModel)
        .background(Color.knobColor.opacity(0.7))
}


