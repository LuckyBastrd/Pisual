//
//  ResultView.swift
//  Pisual
//
//  Created by Lucky on 17/02/25.
//

import SwiftUI

struct FeedbackView: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var windowManager: WindowManager
    @EnvironmentObject var cameraManager: CameraManager
    @EnvironmentObject var feedbackManager: FeedbackManager
    @EnvironmentObject var screenshotManager: ScreenshotManager
    @EnvironmentObject var sceneKitManager: SceneKitManager
    
    var learningProgressManager: LearningProgressManager?
    var phaseCoordinator: PhaseCoordinator?
    
    var isWildMode: Bool = false
    
    private var buttonTitle: String {
        if isWildMode {
            return feedbackManager.passed ? "WELL DONE!" : "KEEP TRYING!"
        } else {
            if feedbackManager.passed {
                if let learningProgressManager = learningProgressManager,
                   learningProgressManager.currentLearnPhase == learningProgressManager.maxLearnPhase {
                    return "THANK YOU!"
                }
                return "NEXT PHASE"
            } else {
                return "TRY AGAIN"
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 43) { 
                if let screenshotImage = screenshotManager.screenshotImage {
                    Image(uiImage: screenshotImage)
                        .resizable()
                        .frame(width: 717, height: 300)
                }
                
                VStack(spacing: 7) {
                    Text("Camera Settings: ")
                        .frame(maxWidth: .infinity, maxHeight: 34, alignment: .leading)
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundStyle(AppColors.textPrimary)
                    
                    SettingsTextView(
                        title: "F-STOP",
                        values: "f\(String(format: "%.1f", feedbackManager.fstop))"
                    )
                    
                    SettingsTextView(
                        title: "SHUTTER",
                        values: (feedbackManager.shutter > 0 && feedbackManager.shutter.isFinite) 
                                ? "1/\(Int(1.0 / feedbackManager.shutter).formatted(.number.grouping(.never)))" 
                                : "N/A"
                    )
                    
                    SettingsTextView(
                        title: "ISO",
                        values: String(format: "%d", Int(feedbackManager.iso))
                    )
                }
                .padding(.horizontal, 17)
                
                VStack(spacing: 7) {
                    Text("Feedback: ")
                        .frame(maxWidth: .infinity, maxHeight: 34, alignment: .leading)
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundStyle(AppColors.textPrimary)
                    
                    Text(feedbackManager.feedback)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .font(.title)
                        .fontWeight(.regular)
                        .foregroundStyle(AppColors.textPrimary)
                }
                .padding(.horizontal, 17)
                
                CustomRoundedRectangleButtonView(
                    title: buttonTitle,
                    titleFont: .title2,
                    titleFontWeight: .heavy
                ) { 
                    withAnimation(.easeInOut(duration: 0.3)) {
                        if feedbackManager.passed {
                            handlePassedFeedback()
                        }
                        
                        windowManager.showFeedbackView = false
                    }
                }
            }
            .padding(.vertical, 45)
            .padding(.horizontal, 25)
        }
        .frame(maxWidth: .infinity, maxHeight: 913)
        .background(AppColors.textContrast)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(AppColors.textPrimary, lineWidth: 5)
        )
        .padding(.horizontal, 33)
    }
    
    private func handlePassedFeedback() {
        if isWildMode {
            feedbackManager.reset()
            cameraManager.reset()
            return
        }
        
        if learningProgressManager?.currentLearnPhase == learningProgressManager?.maxLearnPhase {
            phaseCoordinator?.invalidate()
        }
        
        cameraManager.reset()
        feedbackManager.reset()
        learningProgressManager?.nextPhase()
        sceneKitManager.updateSceneKitLearnMode()
        
        if learningProgressManager?.showFinalMessage == true {
            navigationManager.navigateToFinalMessage()
            learningProgressManager?.showFinalMessage = false
        }
    }
}

