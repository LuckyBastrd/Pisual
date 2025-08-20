//
//  HelpView.swift
//  Pisual
//
//  Created by Lucky on 19/02/25.
//

import SwiftUI

struct HelpView: View {
    
    @EnvironmentObject var windowManager: WindowManager
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 33) {
                HStack(spacing: 0) {
                    Text("How to Play")
                        .frame(maxWidth: .infinity, maxHeight: 41, alignment: .leading)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundStyle(AppColors.textPrimary)
                    
                    CustomCircleButtonView(
                        buttonWidth: 30,
                        buttonHeight: 30,
                        buttonStroke: 2,
                        iconName: "xmark",
                        iconFont: .subheadline,
                        iconFontWeight: .regular
                    ) { 
                        withAnimation(.easeInOut(duration: 0.3)) { 
                            windowManager.showHelp = false
                        }
                    }
                }
                
                VStack(spacing: 43) { 
                    HelpTextView(
                        title: "1. Adjust the Camera Settings",
                        description: "Use the sliders to change ISO, Shutter Speed, and Aperture (f-stop). These settings directly affect the exposure of the scene in real-time!",
                        descriptionHeight: 68
                    )
                    
                    HelpTextView(
                        title: "2. Capture the Scenes",
                        description: "Once you're happy with your settings, press the Capture button to take the shot.",
                        descriptionHeight: 34
                    )
                    
                    HelpTextView(
                        title: "3. Get Feedback",
                        description: "We’ll analyze your shot and provide feedback based on your settings. Is your scene too bright or too dark? Adjust your settings to find the perfect exposure and move to the next level!",
                        descriptionHeight: 102
                    )
                }
                
                Text("📸 Tip: Experiment with different settings to see how they change the scene!")
                    .frame(maxWidth: .infinity, maxHeight: 28, alignment: .leading)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundStyle(AppColors.textPrimary)
            }
            .padding(.vertical, 45)
            .padding(.horizontal, 25)
        }
        .frame(maxWidth: .infinity, maxHeight: 583)
        .background(AppColors.textContrast)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(AppColors.textPrimary, lineWidth: 5)
        )
        .padding(.horizontal, 33)
    }
}
