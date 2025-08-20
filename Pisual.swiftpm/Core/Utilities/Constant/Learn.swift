//
//  Learn.swift
//  Pisual
//
//  Created by Lucky on 19/02/25.
//

import SwiftUI

struct Learn {
    static let phase: [LearnPhaseModel] = [ 
        LearnPhaseModel(
            name: "ISO",
            fStopIndex: RandomHelper.randomInt(in: 6...8),
            shutterIndex: RandomHelper.randomInt(in: 1...3),
            isoIndex: 0,
            hour: RandomHelper.getRandomHour(),
            isFStopActive: false,
            isShutterActive: false,
            isIsoActive: true,
            isNote: true
        ),
        
        LearnPhaseModel(
            name: "ISO",
            fStopIndex: RandomHelper.randomInt(in: 5...10),
            shutterIndex: RandomHelper.randomInt(in: 3...5),
            isoIndex: 0,
            hour: RandomHelper.getRandomHour(),
            isFStopActive: false,
            isShutterActive: false,
            isIsoActive: true,
            isNote: true
        ),
        
        LearnPhaseModel(
            name: "SHUTTER",
            fStopIndex: RandomHelper.randomInt(in: 3...7),
            shutterIndex: 0,
            isoIndex: RandomHelper.randomInt(in: 0...3),
            hour: RandomHelper.getRandomHour(),
            isFStopActive: false,
            isShutterActive: true,
            isIsoActive: false,
            isNote: true
        ),
        
        LearnPhaseModel(
            name: "SHUTTER",
            fStopIndex: RandomHelper.randomInt(in: 5...9),
            shutterIndex: 0,
            isoIndex: RandomHelper.randomInt(in: 0...3),
            hour: RandomHelper.getRandomHour(),
            isFStopActive: false,
            isShutterActive: true,
            isIsoActive: false,
            isNote: true
        ),
        
        LearnPhaseModel(
            name: "FSTOP",
            fStopIndex: 0,
            shutterIndex: RandomHelper.randomInt(in: 3...6),
            isoIndex: RandomHelper.randomInt(in: 0...3),
            hour: RandomHelper.getRandomHour(),
            isFStopActive: true,
            isShutterActive: false,
            isIsoActive: false,
            isNote: true
        ),
        
        LearnPhaseModel(
            name: "FSTOP",
            fStopIndex: 0,
            shutterIndex: RandomHelper.randomInt(in: 2...3),
            isoIndex: RandomHelper.randomInt(in: 0...5),
            hour: RandomHelper.getRandomHour(),
            isFStopActive: true,
            isShutterActive: false,
            isIsoActive: false,
            isNote: true
        ),
        
        LearnPhaseModel(
            name: "All",
            fStopIndex: RandomHelper.randomInt(in: 0...10),
            shutterIndex: RandomHelper.randomInt(in: 0...10),
            isoIndex: RandomHelper.randomInt(in: 0...10),
            hour: RandomHelper.getRandomHour(),
            isFStopActive: true,
            isShutterActive: true,
            isIsoActive: true,
            isNote: false
        ),
        
        LearnPhaseModel(
            name: "All",
            fStopIndex: RandomHelper.randomInt(in: 0...10),
            shutterIndex: RandomHelper.randomInt(in: 0...10),
            isoIndex: RandomHelper.randomInt(in: 0...10),
            hour: RandomHelper.getRandomHour(),
            isFStopActive: true,
            isShutterActive: true,
            isIsoActive: true,
            isNote: false
        ),
    ]
}
