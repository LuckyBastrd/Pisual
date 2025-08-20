//
//  LearningProgressManager.swift
//  Pisual
//
//  Created by Lucky on 19/02/25.
//

import SwiftUI

class LearningProgressManager: ObservableObject {
    
    weak var delegate: PhaseUpdateDelegate?
    
    @Published var currentLearnPhase: Int {
        didSet {
            UserDefaults.standard.set(currentLearnPhase, forKey: "currentLearnPhase")
            checkLearnCompletion()
            
            delegate?.didUpdatePhase(to: currentPhase)
        }
    }
    
    @Published var isWildModeUnlocked: Bool {
        didSet {
            UserDefaults.standard.set(isWildModeUnlocked, forKey: "isWildModeUnlocked")
        }
    }
    
    @Published var showFinalMessage: Bool = false
    
    let maxLearnPhase: Int = Learn.phase.count - 1

    init() {
        self.currentLearnPhase = UserDefaults.standard.integer(forKey: "currentLearnPhase")
        self.isWildModeUnlocked = UserDefaults.standard.bool(forKey: "isWildModeUnlocked")
        
        self.currentLearnPhase = 0
    }
    
    var currentPhase: LearnPhaseModel {
        Learn.phase[currentLearnPhase]
    }

    func nextPhase() {
        if currentLearnPhase < maxLearnPhase {
            currentLearnPhase += 1
        } else {
            isWildModeUnlocked = true
            
            showFinalMessage = true
            
            resetPhase()
        }
    }
    
    func resetPhase() {
        currentLearnPhase = 0
    }

    private func checkLearnCompletion() {
        if currentLearnPhase >= maxLearnPhase {
            isWildModeUnlocked = true
        }
    }
}

