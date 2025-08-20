import SwiftUI

struct CameraControlsView: View {
    
    @EnvironmentObject var cameraManager: CameraManager
    @EnvironmentObject var feedbackManager: FeedbackManager
    
    var learningProgressManager: LearningProgressManager?
    var isWildMode: Bool = false
    
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 33) {
                if isWildMode || (learningProgressManager?.currentPhase.isFStopActive ?? false) {
                    CustomSliderView(
                        selectedIndex: $cameraManager.fstopIndex,
                        title: "F-Stop",
                        leftImage: Image(systemName: "lightbulb.max"),
                        leftImageColor: AppColors.primary,
                        rightImage: Image(systemName: "lightbulb"),
                        rightImageColor: AppColors.textPrimary,
                        values: ExposureValues.fstopValues
                    ) { value in
                        "f/\(String(format: "%.1f", value))"
                    }
                    .onChange(of: cameraManager.fstopIndex) { oldValue, newValue in
                        feedbackManager.fstop = ExposureValues.fstopValues[newValue]
                        
                        NotificationCenter.default.post(name: .updateFStop, object: ExposureValues.fstopValues[newValue])
                    }
                }
                
                if isWildMode || (learningProgressManager?.currentPhase.isShutterActive ?? false) {
                    CustomSliderView(
                        selectedIndex: $cameraManager.shutterIndex,
                        title: "Shutter Speed",
                        leftImage: Image(systemName: "lightbulb"),
                        leftImageColor: AppColors.textPrimary,
                        rightImage: Image(systemName: "lightbulb.max"),
                        rightImageColor: AppColors.primary,
                        values: ExposureValues.shutterValues
                    ) { value in
                        if value < 1 {
                            return "1/\(Int(1 / value))"
                        } else {
                            return "1/1"
                        }
                    }
                    .onChange(of: cameraManager.shutterIndex) { oldValue, newValue in
                        feedbackManager.shutter = ExposureValues.shutterValues[newValue]
                        
                        NotificationCenter.default.post(name: .updateShutter, object: ExposureValues.shutterValues[newValue])
                    }
                }
                
                if isWildMode || (learningProgressManager?.currentPhase.isIsoActive ?? false) {
                    CustomSliderView(
                        selectedIndex: $cameraManager.isoIndex,
                        title: "ISO",
                        leftImage: Image(systemName: "lightbulb"),
                        leftImageColor: AppColors.textPrimary,
                        rightImage: Image(systemName: "lightbulb.max"),
                        rightImageColor: AppColors.primary,
                        values: ExposureValues.isoValues
                    ) { value in
                        "ISO \(Int(value))"
                    }
                    .onChange(of: cameraManager.isoIndex) { oldValue, newValue in
                        feedbackManager.iso = ExposureValues.isoValues[newValue]
                        
                        NotificationCenter.default.post(name: .updateIso, object: ExposureValues.isoValues[newValue])
                    }
                }
            }
            
            if !isWildMode, let learningManager = learningProgressManager, learningManager.currentPhase.isNote {
                NoteView(learningProgressManager: learningManager)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 398, alignment: .top)
        .padding(.vertical, 23)
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
