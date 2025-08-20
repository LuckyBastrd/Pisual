//
//  Note.swift
//  Pisual
//
//  Created by Lucky on 17/02/25.
//

import SwiftUI

enum NoteKeyword: String {
    case fstop = "FSTOP"
    case shutter = "SHUTTER"
    case iso = "ISO"
}

struct Note {
    static let notes: [NoteKeyword: String] = [
        .fstop: 
            """
            The f-stop (f/number) controls how much light enters the camera.

            - Lower f-stop (f/1.4) → More light, brighter image, shallow depth of field. 
            - Higher f-stop (f/22) → Less light, darker image, deep depth of field. 

            Try changing the f-stop and see how brightness adjusts!
            """,
        .shutter: 
            """
            The shutter speed controls how long the camera sensor is exposed to light.  

            - Fast (1/8000s) → Less light, darker image, freezes motion.
            - Slow (1s) → More light, brighter image, but motion blur.

            Experiment with shutter speed to see its impact on brightness!
            """,
        .iso: 
            """
            The ISO controls the camera's sensitivity to light.

            - Low ISO (50) → Less sensitivity, darker image, cleaner quality (less noise).  
            - High ISO (6400) → More sensitivity, brighter image, but more noise (grainy effect).

            Play around with ISO to find the best balance for your scene!
            """
    ]
    
    static func noteFor(keyword: NoteKeyword) -> String? {
        return Note.notes[keyword]
    }
}
