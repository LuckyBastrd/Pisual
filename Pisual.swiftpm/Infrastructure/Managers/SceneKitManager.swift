//
//  SceneKitManager.swift
//  Pisual
//
//  Created by Lucky on 19/02/25.
//

import SwiftUI

class SceneKitManager: ObservableObject {
    
    @Published var isUpdateSceneKitLearnMode: Bool = false
    
    func updateSceneKitLearnMode() {
        isUpdateSceneKitLearnMode = true
        
        DispatchQueue.main.async {
            self.isUpdateSceneKitLearnMode = false
        }
    }
}
