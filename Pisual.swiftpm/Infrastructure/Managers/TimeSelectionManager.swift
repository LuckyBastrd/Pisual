//
//  TimeSelectionManager.swift
//  Pisual
//
//  Created by Lucky on 20/02/25.
//

import SwiftUI 

class TimeSelectionManager: ObservableObject, Resettable {
    
    @Published var selectedHour: Double? = 12
    @Published var isTimeUpdated: Bool = false

    func updateHour(to newHour: Double?, isWildMode: Bool) {
        guard selectedHour != newHour else { return }
        
        selectedHour = newHour
        
        if isWildMode {
            updateSceneKit()
        }
    }
    
    private func updateSceneKit() {
        isTimeUpdated = true
        
        DispatchQueue.main.async {
            self.isTimeUpdated = false
        }
    }
    
    func reset() {
        selectedHour = 12
        isTimeUpdated = false
    }
}

