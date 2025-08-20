//
//  TimeFactorCalculator.swift
//  Pisual
//
//  Created by Lucky on 19/02/25.
//

import SwiftUI

struct TimeFactorCalculator {
    static func calculate(for hour: Double) -> Double {
        
        let minFactor: CGFloat = 0.2
        let dawnDuskFactor: CGFloat = 0.3
        
        let factor: CGFloat
        if hour >= 6 && hour < 12 {
            factor = CGFloat((hour - 6) / 6) * (1.0 - dawnDuskFactor) + dawnDuskFactor
        } else if hour >= 12 && hour < 18 {
            factor = CGFloat((18 - hour) / 6) * (1.0 - dawnDuskFactor) + dawnDuskFactor
        } else if hour < 6 {
            factor = CGFloat(hour / 6) * (dawnDuskFactor - minFactor) + minFactor
        } else {
            factor = CGFloat((24 - hour) / 6) * (dawnDuskFactor - minFactor) + minFactor
        }
        
        return Double(factor)
    }
}

