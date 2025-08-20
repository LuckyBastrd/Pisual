//
//  ExposureValues.swift
//  Pisual
//
//  Created by Lucky on 18/02/25.
//

import SwiftUI

struct ExposureValues {
    static let defaultFStop: Double = 1.4
    static let defaultShutter: Double = 1/8000
    static let defaultISO: Double = 50
    
    static let fstopValues: [Double] = [
        1.4, 1.8, 2.0, 2.8, 3.5, 4.0, 5.6, 8.0, 11.0, 16.0, 22.0
    ]
    
    static let shutterValues: [Double] = [
        1/8000, 1/4000, 1/1000, 1/500, 1/250, 1/125, 1/60, 1/30, 1/8, 1/4, 1/1
    ]
    
    static let isoValues: [Double] = [
        50, 100, 160, 200, 250, 320, 400, 800, 1600, 3200, 6400
    ]
}
