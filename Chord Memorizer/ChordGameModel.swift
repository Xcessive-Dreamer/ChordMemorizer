import Foundation
import Combine


class QuizModel: ObservableObject {
    
    struct ChordChange {
        let originalChord: String
        let targetChordOptions: [String]
        let durationInBeats: Int
    }
    
    struct Song {
        let name: String
        let chordChanges: [ChordChange]
    }
    
    @Published var songs: [Song]
    @Published var correctChordSubject = PassthroughSubject <Bool, Never>()
    @Published var correctCount: Int = 0 // Store the count of correct answers
    @Published var totalCount: Int = 0 // Store the count of correct answers
    @Published var timeBetweenQuestions: Double = 0 // Wait time between questions
    
    
    init() {
        
        // Initialize the songs array with your desired data
        self.songs = [
            Song(name: "Autumn Leaves", chordChanges: [
                // A section
                ChordChange(originalChord: "Am7", targetChordOptions: ["Am7", "Dm7", "G7", "Cmaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "D7", targetChordOptions: ["G7", "Cmaj7", "D7", "F#m7b5"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "GMaj7", targetChordOptions: ["F#m7b5", "GMaj7", "B7", "Em7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "CMaj7", targetChordOptions: ["F#m7b5", "B7", "Em7", "CMaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "F#m7b5", targetChordOptions: ["F#m7b5", "B7", "Em7", "Am7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "B7", targetChordOptions: ["Em7", "Am7", "B7", "D7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Em", targetChordOptions: ["Em", "Am7", "D7", "Gmaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Em", targetChordOptions: ["Am7", "D7", "Gmaj7", "Em"].shuffled(), durationInBeats: 4),
                // repeat
                ChordChange(originalChord: "Am7", targetChordOptions: ["Dm7", "G7", "Cmaj7", "Am7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "D7", targetChordOptions: ["G7", "Cmaj7", "D7", "F#m7b5"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "GMaj7", targetChordOptions: ["GMaj7", "F#m7b5", "B7", "Em7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "CMaj7", targetChordOptions: ["F#m7b5", "CMaj7", "B7", "Em7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "F#m7b5", targetChordOptions: ["F#m7b5", "B7", "Em7", "Am7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "B7", targetChordOptions: ["B7", "Em7", "Am7", "D7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Em", targetChordOptions: ["Em", "Am7", "D7", "Gmaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Em", targetChordOptions: ["Em", "Am7", "D7", "Gmaj7"].shuffled(), durationInBeats: 4),
                // B section
                ChordChange(originalChord: "F#m7b5", targetChordOptions: ["F#m7b5", "B7", "Em7", "Am7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "B7b9", targetChordOptions: ["B7b9", "Em7", "Am7", "D7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Em", targetChordOptions: ["Em", "Am7", "D7", "Gmaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Em", targetChordOptions: ["Em", "Am7", "D7", "Gmaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Am7", targetChordOptions: ["Am7", "Dm7", "G7", "Cmaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "D7", targetChordOptions: ["D7", "G7", "Cmaj7", "F#m7b5"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "GMaj7", targetChordOptions: ["GMaj7", "Cmaj7", "F#m7b5", "B7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "GMaj7", targetChordOptions: ["GMaj7", "Cmaj7", "F#m7b5", "B7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "F#m7b5", targetChordOptions: ["F#m7b5", "B7", "Em7", "Am7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "B7b9", targetChordOptions: ["B7b9", "Em7", "Am7", "D7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Em7", targetChordOptions: ["Em7", "Am7", "D7", "Gmaj7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Eb7", targetChordOptions: ["Eb7", "Abmaj7", "Db7", "Gbmaj7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Dm7", targetChordOptions: ["Dm7", "G7", "Cmaj7", "F#m7b5"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Db7", targetChordOptions: ["Db7", "Gb7", "Bmaj7", "E7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "CMaj7", targetChordOptions: ["CMaj7", "F#m7b5", "B7", "Em7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "B7b9", targetChordOptions: ["B7b9", "Em7", "Am7", "D7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Em", targetChordOptions: ["Em", "Am7", "D7", "Gmaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Em", targetChordOptions: ["Em", "Am7", "D7", "Gmaj7"].shuffled(), durationInBeats: 4),
            ]),
            
            Song(name: "Misty", chordChanges: [
                // A section
                ChordChange(originalChord: "EMaj7", targetChordOptions: ["Am7", "Dm7", "G7", "Cmaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Bbm7", targetChordOptions: ["G7", "Cmaj7", "D7", "F#m7b5"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Eb7", targetChordOptions: ["F#m7b5", "GMaj7", "B7", "Em7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "AbMaj7", targetChordOptions: ["F#m7b5", "B7", "Em7", "CMaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Abm7", targetChordOptions: ["F#m7b5", "B7", "Em7", "Am7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Db7", targetChordOptions: ["Em7", "Am7", "B7", "D7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "EMaj7", targetChordOptions: ["Em", "Am7", "D7", "Gmaj7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Cm7", targetChordOptions: ["Am7", "D7", "Gmaj7", "Em"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Fm7", targetChordOptions: ["Dm7", "G7", "CMaj7", "Am7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Bb7", targetChordOptions: ["G7", "Cmaj7", "D7", "F#m7b5"].shuffled(), durationInBeats: 2),
                // first ending A section
                ChordChange(originalChord: "Gm7", targetChordOptions: ["GMaj7", "F#m7b5", "B7", "Em7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "C7", targetChordOptions: ["F#m7b5", "CMaj7", "B7", "Em7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Fm7", targetChordOptions: ["F#m7b5", "B7", "Em7", "Am7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Bb7", targetChordOptions: ["B7", "Em7", "Am7", "D7"].shuffled(), durationInBeats: 2),
                // repeat A section
                ChordChange(originalChord: "EMaj7", targetChordOptions: ["Am7", "Dm7", "G7", "Cmaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Bbm7", targetChordOptions: ["G7", "Cmaj7", "D7", "F#m7b5"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Eb7", targetChordOptions: ["F#m7b5", "GMaj7", "B7", "Em7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "AbMaj7", targetChordOptions: ["F#m7b5", "B7", "Em7", "CMaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Abm7", targetChordOptions: ["F#m7b5", "B7", "Em7", "Am7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Db7", targetChordOptions: ["Em7", "Am7", "B7", "D7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "EMaj7", targetChordOptions: ["Em", "Am7", "D7", "Gmaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Cm7", targetChordOptions: ["Am7", "D7", "Gmaj7", "Em"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Fm7", targetChordOptions: ["Dm7", "G7", "CMaj7", "Am7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Bb7", targetChordOptions: ["G7", "Cmaj7", "D7", "F#m7b5"].shuffled(), durationInBeats: 4),
                // second ending A section
                ChordChange(originalChord: "Eb6", targetChordOptions: ["GMaj7", "F#m7b5", "B7", "Em7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Eb6", targetChordOptions: ["GMaj7", "F#m7b5", "B7", "Em7"].shuffled(), durationInBeats: 4),
                // B section
                ChordChange(originalChord: "Bbm7", targetChordOptions: ["F#m7b5", "B7", "Em7", "Am7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "E7b9", targetChordOptions: ["B7b9", "Em7", "Am7", "D7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "AbMaj7", targetChordOptions: ["Em", "Am7", "D7", "Gmaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "AbMaj7", targetChordOptions: ["Em", "Am7", "D7", "Gmaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Am7", targetChordOptions: ["Am7", "Dm7", "G7", "Cmaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "D7", targetChordOptions: ["D7", "G7", "Cmaj7", "F#m7b5"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "F7", targetChordOptions: ["GMaj7", "Cmaj7", "F#m7b5", "B7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Gm7b5", targetChordOptions: ["GMaj7", "Cmaj7", "F#m7b5", "B7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "C7b9", targetChordOptions: ["F#m7b5", "B7", "Em7", "Am7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Fm7", targetChordOptions: ["B7b9", "Em7", "Am7", "D7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Bb7", targetChordOptions: ["Em7", "Am7", "D7", "Gmaj7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "EMaj7", targetChordOptions: ["Am7", "Dm7", "G7", "Cmaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Bbm7", targetChordOptions: ["G7", "Cmaj7", "D7", "F#m7b5"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Eb7", targetChordOptions: ["F#m7b5", "GMaj7", "B7", "Em7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "AbMaj7", targetChordOptions: ["F#m7b5", "B7", "Em7", "CMaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Abm7", targetChordOptions: ["F#m7b5", "B7", "Em7", "Am7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Db7", targetChordOptions: ["Em7", "Am7", "B7", "D7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "EMaj7", targetChordOptions: ["Em", "Am7", "D7", "Gmaj7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Cm7", targetChordOptions: ["Am7", "D7", "Gmaj7", "Em"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Fm7", targetChordOptions: ["Dm7", "G7", "CMaj7", "Am7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Bb7", targetChordOptions: ["G7", "Cmaj7", "D7", "F#m7b5"].shuffled(), durationInBeats: 2),
                // ending
                ChordChange(originalChord: "Eb6", targetChordOptions: ["GMaj7", "F#m7b5", "B7", "Em7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Fm7", targetChordOptions: ["GMaj7", "F#m7b5", "B7", "Em7"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "Bb7", targetChordOptions: ["GMaj7", "F#m7b5", "B7", "Em7"].shuffled(), durationInBeats: 2),
            ]),


            Song(name: "1-6-2-5-1", chordChanges: [
                ChordChange(originalChord: "CMaj7", targetChordOptions: ["F#m7b5", "B7", "Em7", "CMaj7"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "Am7", targetChordOptions: ["Dm7", "G7", "Cmaj7", "Am7"].shuffled(), durationInBeats:2),
                ChordChange(originalChord: "Dm7", targetChordOptions: ["Dm7", "G7", "Cmaj7", "F#m7b5"].shuffled(), durationInBeats: 2),
                ChordChange(originalChord: "G7", targetChordOptions: ["Dm7", "G7", "Cmaj7", "F#m7b5"].shuffled(), durationInBeats: 4),
                ChordChange(originalChord: "CMaj7", targetChordOptions: ["F#m7b5", "G7", "E7", "CMaj7"].shuffled(), durationInBeats: 2),
            ]),
        ]
    }
    
    func startGame() {
        correctCount = 0
        totalCount = 0
    }
    
    // Method to check the selected chord
    func checkChord(_ selectedChord: String, against originalChord: String) {
        if selectedChord == originalChord {
            correctChordSubject.send(true)
            correctCount += 1
            totalCount += 1
        } else {
            correctChordSubject.send(false)
            totalCount += 1
        }
    }
}
