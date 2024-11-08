//
//  CatLepaApp.swift
//  CatLepa
//
//  Created by GMachine on 08/11/2024.
//

import SwiftUI
import AVFoundation

@main
struct CatLepaApp: App {
    @StateObject private var audioPlayer = AudioPlayer()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    setupAudioSession() // Set up audio session for background playback
                    audioPlayer.playBackgroundMusic() // Start background music
                }
        }
    }
}

// Audio session setup function
func setupAudioSession() {
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
    } catch {
        print("Failed to set up audio session: \(error)")
    }
}

// AudioPlayer class to handle music playback
class AudioPlayer: ObservableObject {
    var player: AVAudioPlayer?

    func playBackgroundMusic() {
        if let path = Bundle.main.path(forResource: "meow", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.numberOfLoops = -1 // Loop indefinitely
                player?.play()
            } catch {
                print("Error loading and playing audio: \(error)")
            }
        }
    }
}
