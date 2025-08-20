import SwiftUI

@main
struct MyApp: App {
    
    @StateObject private var navigationManager = NavigationManager()
    @StateObject private var windowManager = WindowManager()
    @StateObject private var sceneKitManager = SceneKitManager()
    @StateObject private var learningProgressManager = LearningProgressManager()
    @StateObject private var timeSelectionManager = TimeSelectionManager()
    @StateObject private var cameraManager = CameraManager()
    @StateObject private var feedbackManager = FeedbackManager()
    @StateObject private var screenShotManager = ScreenshotManager()
    
    var body: some Scene {
        WindowGroup {           
            ZStack {
                NavigationStack(path: $navigationManager.navigationPath) {
                    StartView()
                        .navigationDestination(for: LearnPhaseViewModel.self) { _ in
                            LearnPhaseView()
                        }
                        .navigationDestination(for: WildModeViewModel.self) { _ in
                            WildModeView()
                        }
                        .navigationDestination(for: FinalMessageViewModel.self) { _ in
                            FinalMessageView()
                        }
                }
                .environmentObject(navigationManager)
                .environmentObject(windowManager)
                .environmentObject(sceneKitManager)
                .environmentObject(learningProgressManager)
                .environmentObject(timeSelectionManager)
                .environmentObject(cameraManager)
                .environmentObject(feedbackManager)
                .environmentObject(screenShotManager)
                
                MusicButtonView()
            }
        }
    }
}
