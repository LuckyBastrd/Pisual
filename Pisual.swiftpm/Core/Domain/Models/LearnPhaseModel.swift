//
//  LearnPhaseModel.swift
//  Pisual
//
//  Created by Lucky on 18/02/25.
//

import SwiftUI

struct LearnPhaseModel: Equatable {
    let name: String
    let fStopIndex: Int
    let shutterIndex: Int
    let isoIndex: Int
    let hour: Double
    let isFStopActive: Bool
    let isShutterActive: Bool
    let isIsoActive: Bool
    let isNote: Bool
    
    static func ==(lhs: LearnPhaseModel, rhs: LearnPhaseModel) -> Bool {
        return lhs.name == rhs.name &&
            lhs.fStopIndex == rhs.fStopIndex &&
            lhs.shutterIndex == rhs.shutterIndex &&
            lhs.isoIndex == rhs.isoIndex &&
            lhs.hour == rhs.hour &&
            lhs.isFStopActive == rhs.isFStopActive &&
            lhs.isShutterActive == rhs.isShutterActive &&
            lhs.isIsoActive == rhs.isIsoActive &&
            lhs.isNote == rhs.isNote
    }
}

