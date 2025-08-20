//
//  RandomHelper.swift
//  Pisual
//
//  Created by Lucky on 19/02/25.
//

import SwiftUI

struct RandomHelper {
    static func randomInt(in range: ClosedRange<Int>) -> Int {
        return Int.random(in: range)
    }
    
    static func getRandomHour() -> Double {
        let values = [0, 7, 12, 18, 20]
        return Double(values.randomElement() ?? 0)
    }
}
