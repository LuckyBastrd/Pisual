import SwiftUI

class CameraManager: ObservableObject, Resettable {
    
    @Published var fstopIndex: Int = 0 
    @Published var shutterIndex: Int = 0
    @Published var isoIndex: Int = 0
    
    func updateIndex(fstopIndex: Int, shutterIndex: Int, Isoindex: Int) {
        self.fstopIndex = fstopIndex
        self.shutterIndex = shutterIndex
        self.isoIndex = Isoindex
    }
    
    func reset() {
        self.fstopIndex = 0
        self.shutterIndex = 0
        self.isoIndex = 0
    }
}
