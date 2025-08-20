import SwiftUI

struct LearnPhaseView: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var windowManager: WindowManager
    @EnvironmentObject var timeSelectionManger: TimeSelectionManager
    @EnvironmentObject var learningProgressManager: LearningProgressManager
    @EnvironmentObject var cameraManager: CameraManager
    @EnvironmentObject var feedbackManager: FeedbackManager
    
    @State private var phaseCoordinator: PhaseCoordinator?
    
    var body: some View {
        ZStack {
            VStack(spacing: 43) {
                CameraView(learningProgressManager: learningProgressManager)
                
                CameraControlsView(learningProgressManager: learningProgressManager)
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
                
                FeedbackView(
                    learningProgressManager: learningProgressManager,
                    phaseCoordinator: phaseCoordinator)
                .transition(.scale)
                .animation(.easeInOut(duration: 0.5), value: windowManager.showFeedbackView)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // Back Button
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    phaseCoordinator?.invalidate()
                    
                    timeSelectionManger.reset()
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
        .onAppear {
            if phaseCoordinator == nil {
                phaseCoordinator = PhaseCoordinator(
                    learningProgressManager: learningProgressManager,
                    timeSelectionManager: timeSelectionManger,
                    cameraManager: cameraManager,
                    feedbackManager: feedbackManager
                )
            }
        }
    }
}
