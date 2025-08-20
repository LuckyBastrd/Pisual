//
//  PhaseUpdateDelegate.swift
//  Pisual
//
//  Created by Lucky on 20/02/25.
//

import SwiftUI

protocol PhaseUpdateDelegate: AnyObject {
    func didUpdatePhase(to phase: LearnPhaseModel)
}
