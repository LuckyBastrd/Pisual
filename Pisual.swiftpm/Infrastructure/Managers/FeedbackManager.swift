//
//  ResultManager.swift
//  Pisual
//
//  Created by Lucky on 18/02/25.
//

import SwiftUI

class FeedbackManager: ObservableObject, Resettable {

    @Published var fstop: Double = 1.4
    @Published var shutter: Double = 1/8000
    @Published var iso: Double = 50
    @Published var timeFactor: Double = 0.0
    
    @Published var feedback: String = ""
    @Published var passed: Bool = false
    
    func nearestValue(_ value: Double, in values: [Double]) -> Double {
        return values.min(by: { abs($0 - value) < abs($1 - value) }) ?? value
    } 
    
    func feedback(for adjustableParameter: String) {
        let tolerance = 0.1
        
        switch adjustableParameter {
        case "ISO":
            let shutterEffect = shutter / ExposureValues.defaultShutter
            let fStopEffect = pow(ExposureValues.defaultFStop / fstop, 2)
            let continuousIdealISO = ExposureValues.defaultISO / (shutterEffect * fStopEffect * Double(timeFactor))
            let idealISO = nearestValue(continuousIdealISO, in: ExposureValues.isoValues)
            let error = (iso / idealISO) - 1.0
            
            if abs(error) <= tolerance {
                self.feedback = "Well done! Your ISO is set just right for these conditions. In this learn phase, adjusting ISO modifies brightness by changing sensor sensitivity. Keep exploring how small changes can make a big difference."
                self.passed = true
                return
            }
            
            var feedbackString = "In this learn phase, only ISO is adjustable while shutter speed and f‑stop remain fixed. Here, ISO primarily controls brightness. "
            if error > 0 {
                feedbackString += "The current ISO is a bit high, which increases sensitivity and makes the image brighter. Try lowering the ISO slightly to see how the brightness adjusts."
            } else {
                feedbackString += "The current ISO is a bit low, reducing sensitivity and resulting in a darker image. Consider increasing the ISO a little to achieve a brighter exposure."
            }
            feedbackString += " This is a great opportunity to learn how sensor sensitivity affects brightness. Experiment and observe the changes."
            self.feedback = feedbackString
            self.passed = false

        case "SHUTTER":
            let isoEffect = iso / ExposureValues.defaultISO
            let fStopEffect = pow(ExposureValues.defaultFStop / fstop, 2)
            let continuousIdealShutter = ExposureValues.defaultShutter / (isoEffect * fStopEffect * Double(timeFactor))
            let idealShutter = nearestValue(continuousIdealShutter, in: ExposureValues.shutterValues)
            let error = (shutter / idealShutter) - 1.0
            
            if abs(error) <= tolerance {
                self.feedback = "Well done! Your shutter speed is perfectly set. In this learn phase, shutter speed is used to adjust brightness (though it can also affect motion blur in other settings)."
                self.passed = true
                return
            }
            
            var feedbackString = "In this learn phase, only shutter speed is adjustable while ISO and f‑stop are fixed, and it primarily affects brightness. "
            if error > 0 {
                feedbackString += "Your current shutter speed is a bit slow, letting in more light and resulting in a brighter image. Try a faster shutter speed to reduce brightness."
            } else {
                feedbackString += "Your current shutter speed is a bit fast, limiting the light and making the image darker. Consider a slower shutter speed to increase brightness."
            }
            feedbackString += " Experimenting with shutter speed can help you see how light control impacts your images."
            self.feedback = feedbackString
            self.passed = false

        case "FSTOP":
            let isoEffect = iso / ExposureValues.defaultISO
            let shutterEffect = shutter / ExposureValues.defaultShutter
            let continuousIdealFStop = ExposureValues.defaultFStop * sqrt(isoEffect * shutterEffect * Double(timeFactor))
            let idealFStop = nearestValue(continuousIdealFStop, in: ExposureValues.fstopValues)
            let error = (fstop / idealFStop) - 1.0
            
            if abs(error) <= tolerance {
                self.feedback = "Well done! Your f‑stop is set ideally. In this learn phase, f‑stop adjustments help control brightness, even though they also affect depth of field in other situations."
                self.passed = true
                return
            }
            
            var feedbackString = "In this learn phase, only f‑stop is adjustable while ISO and shutter speed remain fixed, and here it mainly affects brightness. "
            if error > 0 {
                feedbackString += "The current f‑stop is a bit high, narrowing the aperture and making the image darker. Try decreasing the f‑stop slightly to let in more light."
            } else {
                feedbackString += "The current f‑stop is a bit low, opening the aperture and making the image brighter. Consider increasing the f‑stop a little to balance the brightness."
            }
            feedbackString += " Adjusting the f‑stop is a great way to learn how aperture size influences the light in your images."
            self.feedback = feedbackString
            self.passed = false

        case "All":
            let isoEffect = iso / ExposureValues.defaultISO
            let shutterEffect = shutter / ExposureValues.defaultShutter
            let fStopEffect = pow(ExposureValues.defaultFStop / fstop, 2)
            let combinedExposure = isoEffect * shutterEffect * fStopEffect * timeFactor
            let error = combinedExposure - 1.0

            if abs(error) <= tolerance {
                self.feedback = "Well done! Your overall exposure is balanced. In this learn phase, the combined adjustments help control brightness, showing a good understanding of how each setting works together."
                self.passed = true
                return
            }

            var feedbackString = "The overall exposure is not quite balanced yet. In this learn phase, all adjustments are focused on controlling brightness. "
            if error > 0 {
                feedbackString += "The image is a bit too bright. You might try lowering the ISO, using a faster shutter speed, or increasing the f‑stop slightly."
            } else {
                feedbackString += "The image is a bit too dark. Consider raising the ISO, using a slower shutter speed, or decreasing the f‑stop a bit."
            }
            feedbackString += " Use this opportunity to explore how the combination of settings influences brightness."
            self.feedback = feedbackString
            self.passed = false

        default:
            self.feedback = "Invalid adjustable parameter. Please select ISO, SHUTTER, FSTOP, or All."
            self.passed = false
        }
    }

    
    func updateValue(fstop: Double, shutter: Double, iso: Double, timeFactor: Double) {
        self.fstop = fstop
        self.shutter = shutter
        self.iso = iso
        self.timeFactor = timeFactor
    }
    
    func reset() {
        self.fstop = 1.4 
        self.shutter = 1/8000
        self.iso = 50
        self.timeFactor = 0.0
        
        self.feedback = ""
        self.passed = false
    }
}
