//
//  WildModeView.swift
//  Pisual
//
//  Created by Lucky on 19/02/25.
//

import SwiftUI

struct WildModeView: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var windowManager: WindowManager
    @EnvironmentObject var cameraManager: CameraManager
    @EnvironmentObject var feedbackManager: FeedbackManager
    
    var body: some View {
        ZStack { 
            VStack(spacing: 43) {
                CameraView(isWildMode: true)
                
                CameraControlsView(isWildMode: true)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColors.neutral)
            
            if windowManager.showHelp {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) { 
                            windowManager.showHelp = false
                        }
                    }
                
                HelpView()
                    .transition(.scale)
                    .animation(.easeInOut(duration: 0.5), value: windowManager.showHelp)
            }
            
            if windowManager.showFeedbackView {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                
                FeedbackView(isWildMode: true)
                .transition(.scale)
                .animation(.easeInOut(duration: 0.5), value: windowManager.showFeedbackView)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // Back Button
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    feedbackManager.reset()
                    cameraManager.reset()
                    
                    navigationManager.goToRoot()
                }) {
                    Image(systemName: "arrow.backward")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundColor(AppColors.primary)
                }
                .disabled(windowManager.showFeedbackView || windowManager.showHelp)
            }
            
            ToolbarItem(placement: .principal) {
                Image("PisualLogo")
                    .resizable()
                    .frame(width: 116, height: 36)
            }
            
            // Help Button
            ToolbarItem(placement: .navigationBarTrailing) {
                CustomCircleButtonView(
                    buttonWidth: 30,
                    buttonHeight: 30,
                    buttonStroke: 2,
                    iconName: "questionmark",
                    iconFont: .subheadline,
                    iconFontWeight: .regular
                ) { 
                    withAnimation(.easeInOut(duration: 0.3)) { 
                        windowManager.showHelp = true
                    }
                }
                .disabled(windowManager.showFeedbackView || windowManager.showHelp)
            }
        }
    }
}
