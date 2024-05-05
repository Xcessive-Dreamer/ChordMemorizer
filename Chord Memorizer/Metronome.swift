import Foundation
import AVFoundation
import SwiftUI
import Combine

class Metronome {
    @Published public var metronomeTimer: Timer?
    private var audioPlayer: AVAudioPlayer?
    public var count: Int = 1
    public var chordDuration: Int = 1
    // Publisher for new bar events (signal)
    let barPublisher = PassthroughSubject<Void, Never>()
    private var interval: TimeInterval = 0
    public var delay: Double = 1
    public var beatsPerMeasure: Double = 4
    public var isMetronomeMode: Bool = false
    public var isSongMode: Bool = false
    public var onAppearFinished: Bool = false
    public var songURL: String = ""

    init(songURL: String?, isMetronomeMode: Bool = false, isSongMode: Bool = false) {
            self.songURL = songURL ?? "metronome"
            self.isMetronomeMode = isMetronomeMode
            self.isSongMode = isSongMode
            self.chordDuration = 4
            setupAudioPlayer()
    }

    private func setupAudioPlayer() {
        var soundURL: URL

        // setup metronome as default
        guard let metronomeURL = Bundle.main.url(forResource: "metronome_click", withExtension: "mp3") else {
            fatalError("Metronome sound file not found.")
        }

        if isSongMode {
            guard let songURL = Bundle.main.url(forResource: songURL , withExtension: "mp3") else {
                fatalError("Song sound file not found.")
            }
            soundURL = songURL
        } else {
            soundURL = metronomeURL
        }

        // Initialize audio player with the selected URL
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
        } catch {
            fatalError("Unable to create audio player.")
        }
    }

    func stop() {
        metronomeTimer?.invalidate()
        metronomeTimer = nil
        audioPlayer?.stop()
        audioPlayer = nil
    }

    func toggleMetronome(bpm: Int, chordDuration: Double? = nil) {
        if metronomeTimer?.isValid == true {
            metronomeTimer?.invalidate()
            count = 1
        } else {
            let interval: TimeInterval = 60.0 / Double(bpm)
            delay = interval
            metronomeTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
               self?.tick()
            }
            audioPlayer?.play()
        }
    }

    private func tick() {
        count += 1
        
        if count > chordDuration && !isMetronomeMode {
            barPublisher.send()
            count = 1
        }
        
        if isMetronomeMode && count > 4 {
            count = 1;
        }
    }
}
