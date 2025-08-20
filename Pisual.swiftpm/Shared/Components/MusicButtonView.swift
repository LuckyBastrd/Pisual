//
//  MusicButtonView.swift
//  Pisual
//
//  Created by Lucky on 22/02/25.
//

import SwiftUI

struct MusicButtonView: View {
    
    @ObservedObject var audioManager = AudioManager.shared

    var body: some View {
        VStack(spacing: 0) {
            
            Spacer()
            
            HStack(spacing: 0) {
               
                Spacer()
                
                CustomCircleButtonView(
                    buttonWidth: 40,
                    buttonHeight: 40,
                    buttonStroke: 2,
                    iconName: audioManager.isPlaying ? "pause.fill" : "play.fill",
                    iconFont: .subheadline,
                    iconFontWeight: .bold
                ) { 
                    audioManager.toggleMusic()
                }
                .padding(.trailing, 53)
                .padding(.bottom, 37)
            }
        }
    }
}

