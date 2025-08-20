import SwiftUI

class NavigationManager: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    func navigateToLearnPhaseView() {
        navigationPath.append(LearnPhaseViewModel())
    }
    
    func navigateToWildMode() {
        navigationPath.append(WildModeViewModel())
    }
    
    func navigateToFinalMessage() {
        navigationPath.append(FinalMessageViewModel())
    }
    
    func goToRoot() {
        navigationPath = NavigationPath()
    }
}
