//
//  CameraView.swift
//  Pisual
//
//  Created by Lucky on 17/02/25.
//

import SwiftUI

struct CameraView: View {
    
    @EnvironmentObject var windowManager: WindowManager
    @EnvironmentObject var timeSelectionManager: TimeSelectionManager
    @EnvironmentObject var cameraManager: CameraManager
    @EnvironmentObject var feedbackManager: FeedbackManager
    @EnvironmentObject var screenshotManager: ScreenshotManager
    
    var learningProgressManager: LearningProgressManager? = nil
    var isWildMode: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                SceneKitViewContainer(learningProgressManager: learningProgressManager)
                    .frame(maxWidth: 717, maxHeight: 300)
                
                Image("CameraRuleOfThird")
                    .resizable()
                    .frame(maxWidth: 717, maxHeight: 300)
            }
            .customCornerRadius(topLeft: 20, topRight: 20, bottomLeft: 0, bottomRight: 0)
            
            Divider()
                .frame(maxWidth: 717, maxHeight: 13)
                .background(AppColors.textPrimary)
            
            ZStack {
                HStack(spacing: 0) {
                    HStack(spacing: 43) { 
                        CameraInformationView(title: "F-STOP", type: .fStop)
                        CameraInformationView(title: "SHUTTER", type: .shutter)
                        CameraInformationView(title: "ISO", type: .iso)
                    }
                    .padding(.leading, 33)
                    .padding(.trailing, 33)
                    
                    CustomCircleButtonView(
                        buttonWidth: 70,
                        buttonHeight: 70,
                        iconName: "camera"
                    ) { 
                        withAnimation(.easeInOut(duration: 0.3)) {
                            screenshotManager.takeScreenshot()
                            
                            if isWildMode {
                                if let selectedTime = timeSelectionManager.selectedHour {
                                    feedbackManager.timeFactor = TimeFactorCalculator.calculate(for: selectedTime)
                                }

                                feedbackManager.feedback(for: "All")
                            } else {
                                feedbackManager.feedback(for: learningProgressManager?.currentPhase.name ?? "Unknown Phase")
                            }
                            
                            windowManager.showFeedbackView = true
                        }
                    }
                }
                .frame(maxWidth: 717, maxHeight: 100, alignment: .leading)
                .background(AppColors.textContrast)
                .customCornerRadius(topLeft: 0, topRight: 0, bottomLeft: 20, bottomRight: 20)
                
                // Time Picker
                DropDownPickerView(
                    selection: Binding<Double?>(
                        get: { timeSelectionManager.selectedHour },
                        set: { newHour in
                            timeSelectionManager.updateHour(to: newHour, isWildMode: isWildMode)
                        }
                    ),
                    options: [
                        ("Midnight", 0),
                        ("Morning", 7),
                        ("Daylight", 12),
                        ("Sunset", 18),
                        ("Evening", 20)
                    ],
                    isWildMode: isWildMode
                )
                .disabled(!isWildMode)
                .padding(.bottom, 3)
                .padding(.leading, 429)
                .padding(.trailing, 33)
            }
        }
        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(AppColors.textPrimary, lineWidth: 5)
        )
    }
}
