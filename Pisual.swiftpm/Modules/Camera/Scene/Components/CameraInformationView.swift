//
//  CameraInformationView.swift
//  Pisual
//
//  Created by Lucky on 17/02/25.
//

import SwiftUI

enum CameraSettingsType {
    case fStop, shutter, iso
}

struct CameraInformationView: View {
    
    @EnvironmentObject var cameraManager: CameraManager

    let title: String
    let type: CameraSettingsType

    var value: Double {
        switch type {
        case .fStop:
            return ExposureValues.fstopValues[cameraManager.fstopIndex]
        case .shutter:
            return ExposureValues.shutterValues[cameraManager.shutterIndex]
        case .iso:
            return ExposureValues.isoValues[cameraManager.isoIndex]
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.body)
                .fontWeight(.bold)
                .foregroundStyle(AppColors.textPrimary)
            
            switch type {
            case .fStop:
                Text("f\(String(format: "%.1f", value))")
                    .frame(width: 63)
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundStyle(AppColors.textPrimary)
            case .shutter:
                Text(value < 1 ? "1/\(Int(1.0 / value).formatted(.number.grouping(.never)))" : "1/1")
                    .frame(width: 79)
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundStyle(AppColors.textPrimary)
            case .iso:
                Text(String(format: "%d", Int(value)))
                    .frame(width: 42)
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundStyle(AppColors.textPrimary)
            }
        }
    }
}

