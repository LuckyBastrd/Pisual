//
//  AudioManager.swift
//  Pisual
//
//  Created by Lucky on 22/02/25.
//

import SwiftUI
import AVFoundation

class AudioManager: ObservableObject {
    
    static let shared = AudioManager()

    private var musicPlayer: AVAudioPlayer?
    @Published var isPlaying = true

    init() {
        guard let url = Bundle.main.url(forResource: "Peacefully", withExtension: "mp3") else {
            print("Audio file not found")
            return
        }

        do {
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            
            musicPlayer?.numberOfLoops = -1
            
            musicPlayer?.volume = 0.003
            
            playMusic()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }

    func playMusic() {
        musicPlayer?.play()
        isPlaying = true
    }
    
    func stopMusic() {
        musicPlayer?.pause()
        isPlaying = false
    }

    func toggleMusic() {
        if isPlaying {
            stopMusic()
        } else {
            playMusic()
        }
    }
}

