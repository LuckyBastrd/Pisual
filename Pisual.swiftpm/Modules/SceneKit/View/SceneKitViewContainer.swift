import SwiftUI

struct SceneKitViewContainer: UIViewControllerRepresentable {
    
    @EnvironmentObject var sceneKitManager: SceneKitManager
    @EnvironmentObject var timeSelectionManager: TimeSelectionManager
    @EnvironmentObject var screenshotManager: ScreenshotManager
    
    var learningProgressManager: LearningProgressManager?
    
    func makeUIViewController(context: Context) -> SceneKitViewController {
        let viewController = SceneKitViewController()
        
        if let learningProgressManager = learningProgressManager {
            // Learning Mode
            viewController.fStop = ExposureValues.fstopValues[learningProgressManager.currentPhase.fStopIndex]
            viewController.shutter = ExposureValues.shutterValues[learningProgressManager.currentPhase.shutterIndex]
            viewController.iso = ExposureValues.isoValues[learningProgressManager.currentPhase.isoIndex]
            viewController.timeFactor = TimeFactorCalculator.calculate(for: learningProgressManager.currentPhase.hour)
        } else {
            if let selectedTime = timeSelectionManager.selectedHour {
                viewController.timeFactor = TimeFactorCalculator.calculate(for: selectedTime)
            }
        }
        
        DispatchQueue.main.async {
            screenshotManager.setSceneView(viewController.sceneView)
        }
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: SceneKitViewController, context: Context) {
        if let learningProgressManager = learningProgressManager, sceneKitManager.isUpdateSceneKitLearnMode {
            uiViewController.fStop = ExposureValues.fstopValues[learningProgressManager.currentPhase.fStopIndex]
            uiViewController.shutter = ExposureValues.shutterValues[learningProgressManager.currentPhase.shutterIndex]
            uiViewController.iso = ExposureValues.isoValues[learningProgressManager.currentPhase.isoIndex]
            uiViewController.timeFactor = TimeFactorCalculator.calculate(for: learningProgressManager.currentPhase.hour)
            
            uiViewController.updateExposure()
        } else if timeSelectionManager.isTimeUpdated {
            if let selectedTime = timeSelectionManager.selectedHour {
                uiViewController.timeFactor = TimeFactorCalculator.calculate(for: selectedTime)
                
                uiViewController.updateExposure()
            }
        }
    }
}
