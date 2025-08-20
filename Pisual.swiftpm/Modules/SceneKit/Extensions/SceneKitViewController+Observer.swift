import SwiftUI

extension SceneKitViewController {
    func addObserverListener() {        
        NotificationCenter.default.addObserver(forName: .updateFStop, object: nil, queue: .main) { [weak self] notification in
            if let fstop = notification.object as? Double {
                self?.fStop = fstop
                
                self?.camera.fStop = fstop
                
                self?.updateExposure()
            }
        }
        
        NotificationCenter.default.addObserver(forName: .updateShutter, object: nil, queue: .main) { [weak self] notification in
            if let shuttterSpeed = notification.object as? Double {
                self?.shutter = shuttterSpeed
                
                self?.updateExposure()
            }
        }
        
        NotificationCenter.default.addObserver(forName: .updateIso, object: nil, queue: .main) { [weak self] notification in
            if let iso = notification.object as? Double {
                self?.iso = iso
                
                self?.updateExposure()
            }
        }
    }
    
    func removeObserverListener() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self, name:.updateFStop, object: nil)
        NotificationCenter.default.removeObserver(self, name:.updateShutter, object: nil)
        NotificationCenter.default.removeObserver(self, name:.updateIso, object: nil)
    }
}
