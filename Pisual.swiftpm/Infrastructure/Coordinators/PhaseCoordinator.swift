//
//  PhaseCoordinator.swift
//  Pisual
//
//  Created by Lucky on 20/02/25.
//

import SwiftUI

class PhaseCoordinator: PhaseUpdateDelegate {
    
    var isResetting = false
    
    private let learningProgressManager: LearningProgressManager
    private let timeSelectionManager: TimeSelectionManager
    private let cameraManager: CameraManager
    private let feedbackManager: FeedbackManager

    init(learningProgressManager: LearningProgressManager, 
         timeSelectionManager: TimeSelectionManager, 
         cameraManager: CameraManager, 
         feedbackManager: FeedbackManager) {
        
        self.learningProgressManager = learningProgressManager
        self.timeSelectionManager = timeSelectionManager
        self.cameraManager = cameraManager
        self.feedbackManager = feedbackManager
        
        // Set self as delegate so that phase updates are received.
        self.learningProgressManager.delegate = self
        
        // Immediately update with the current phase.
        didUpdatePhase(to: learningProgressManager.currentPhase)
    }
    
    func invalidate() {
        isResetting = true
        
        learningProgressManager.delegate = nil
    }
    
    func didUpdatePhase(to phase: LearnPhaseModel) {
        guard !isResetting else { return }
        
        DispatchQueue.main.async {
            self.timeSelectionManager.updateHour(to: phase.hour, isWildMode: false)
            
            self.cameraManager.updateIndex(
                fstopIndex: phase.fStopIndex,
                shutterIndex: phase.shutterIndex,
                Isoindex: phase.isoIndex
            )
            
            self.feedbackManager.updateValue(
                fstop: ExposureValues.fstopValues[phase.fStopIndex],
                shutter: ExposureValues.shutterValues[phase.shutterIndex],
                iso: ExposureValues.isoValues[phase.isoIndex],
                timeFactor: TimeFactorCalculator.calculate(for: phase.hour)
            )
        }
    }
}
