//
//  ScreenshotManager.swift
//  Pisual
//
//  Created by Lucky on 17/02/25.
//

import SwiftUI
import SceneKit

class ScreenshotManager: ObservableObject {
    
    @Published var screenshotImage: UIImage?

    private weak var sceneView: SCNView?

    func setSceneView(_ view: SCNView) {
        self.sceneView = view
    }
    
    func takeScreenshot() {
        guard let sceneView = sceneView else { return }
        
        // Capture the scene image using SCNView's snapshot() method.
        let image = sceneView.snapshot()
        screenshotImage = image
    }
}
