import SwiftUI

struct StartView: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var learningProgressManager: LearningProgressManager
    @EnvironmentObject var audioManager: AudioManager
    
    private var buttonTitle: String {
        let currentIndex = learningProgressManager.currentLearnPhase
        let hasUnlockedWildMode = learningProgressManager.isWildModeUnlocked

        if currentIndex == 0 && !hasUnlockedWildMode {
            return "SNAP & LEARN"
        } else if currentIndex == 0 && hasUnlockedWildMode {
            return "KEEP LEARNING"
        } else {
            return "CONTINUE"
        }
    }
    
    var body: some View {
        VStack(spacing: 220) {
            Image("PisualLogo")
                .resizable()
                .padding()
                .frame(width: 1025, height: 319)
            
            VStack(spacing: 13) {
                CustomRoundedRectangleButtonView(
                    title: buttonTitle,
                    titleFont: .largeTitle,
                    titleFontWeight: .heavy
                ) { 
                    navigationManager.navigateToLearnPhaseView()
                }
                
                CustomRoundedRectangleButtonView(
                    title: "GO WILD",
                    titleFont: .title,
                    titleFontWeight: .heavy
                ) { 
                    navigationManager.navigateToWildMode()
                }
                .disabled(!learningProgressManager.isWildModeUnlocked)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.neutral)
    }
}
