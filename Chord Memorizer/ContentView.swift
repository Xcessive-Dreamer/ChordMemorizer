import SwiftUI
import AVFoundation
import Combine

struct ContentView: View {
    @State private var selectedGenre: String = "Jazz"
    let genres = ["Jazz", "Pop", "Rock", "Country"]
    public var songURL: String = ""
    
    @StateObject var quizModel = QuizModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Title
                Text("Welcome To The Chord \n Progression Memorizer!")
                    .bold()
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding()

                // About game
                Text("The Chord Progression Memorizer empowers you to practice your favorite music anytime, anywhere. Select a genre below or add your own changes to get started memorizing songs.")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding()

                // Genre Picker
                Picker("Select Genre", selection: $selectedGenre) {
                    ForEach(genres, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Navigation Button
                NavigationLink(destination: genrePageView(for: selectedGenre)) {
                    Text("Go to \(selectedGenre)")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: AddOwnPageView()) {
                    Text("Add Your Own")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: MetronomePageView()) {
                    Text("Metronome")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding(20)
            .background(Color(red: 0.8, green: 0.95, blue: 0.8))
            .navigationBarTitle(Text("Xcessive-Music"), displayMode: .large)
        }
    }

    private func genrePageView(for genre: String) -> some View {
        switch genre {
        case "Jazz":
            return AnyView(JazzPageView())
        case "Pop":
            return AnyView(PopPageView())
        case "Rock":
            return AnyView(RockPageView())
        case "Country":
            return AnyView(CountryPageView())
        default:
            return AnyView(EmptyView())
        }
    }
}

struct JazzPageView: View {
    
    var body: some View {
            VStack {
                // Title
                Text("Jazz Standard Progressions and Songs")
                    .bold()
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .background(Color.black)
                    .cornerRadius(10)
                
                NavigationLink(destination: CommonJazzChordProgressionsView()) {
                    Text("Common Jazz Chord Changes")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: JazzQuizSelectionView())  {
                    Text("Jazz Standard Chord Change Quizzes")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding(20)
            .background(Color(red: 0.8, green: 0.95, blue: 0.8))
            .navigationBarTitle(Text("Jazz Standards"), displayMode: .large)
    }
}
 
// eventually want to implement search based system for the songs
struct JazzQuizSelectionView: View {
    //let model = QuizModel()
    @EnvironmentObject var model : QuizModel
    @State private var selectedSongIndex: Int = 0
    @State private var selectedSongName: String = "" // New state variable for the selected song name
    @State private var isActive: Bool = false
    @State private var selectedBPM: Double = 90.0 // Default BPM value
    let bpmOptions = [60.0, 90.0, 120.0]
    
    var body: some View {
        VStack {
            // Title
            Text("Jazz Standard Chord Memorization Quizzes")
                .bold()
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(Color.black)
                .cornerRadius(10)
            
            Spacer()
            
            // Slider for BPM selection
            Slider(value: $selectedBPM, in: 60...120, step: 30)
                .padding(30)
            
            Text("Tempo(BPM): \(Int(selectedBPM))")
                .padding()
            
            Picker("Select a song", selection: $selectedSongIndex) {
                ForEach(model.songs.indices, id: \.self) { index in
                    Text(model.songs[index].name).tag(index)
                        .foregroundColor(.white)
                }
            }
            .onChange(of: selectedSongIndex) {
                // update the selected song to update audio file
                selectedSongName = model.songs[selectedSongIndex].name
                //print(selectedSongName)
            }
            
            .pickerStyle(MenuPickerStyle())
            .background(Color.black)
            .accentColor(.white)
            .padding(30)

            Button(action: {
                //print(selectedSongName)
                model.startGame()
                selectedSongName = model.songs[selectedSongIndex].name // Update the selected song name
                isActive = true // Set isActive to true when the button is tapped
            }) {
                NavigationLink(destination: JazzQuizView(songName: selectedSongName, songIndex: selectedSongIndex, tempo: Int(selectedBPM))) {
                    Text("Start Quiz")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(Color.black)
                        .cornerRadius(10)
                }
            }
            Spacer()
        }
        .padding()
        .background(Color(red: 0.8, green: 0.95, blue: 0.8))
        .navigationBarTitle(Text("Jazz Standards"), displayMode: .large)
    }
}

struct OneSixTwoFivePageView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                // Title
                Text("1-6-2-5 Progression In C Major")
                    .bold()
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .background(Color.black)
                    .cornerRadius(10)
                Image("1625")
                    .resizable()

                Spacer()

            }
            .padding(20)
            .background(Color(red: 0.8, green: 0.95, blue: 0.8))
        }
    }
}

struct CommonJazzChordProgressionsView: View {
    
    var body: some View {
            VStack {
                // Title
                Text("Common Jazz Standards")
                    .bold()
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .background(Color.black)
                    .cornerRadius(10)
                
                NavigationLink(destination: OneSixTwoFivePageView()) {
                    Text("One-Six-Two-Five")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: OneSixTwoFivePageView()) {
                    Text("One-Six-Two-Five")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding(20)
            .background(Color(red: 0.8, green: 0.95, blue: 0.8))
            .navigationBarTitle(Text("Jazz Standards"), displayMode: .large)
    }
}

struct JazzQuizView: View {
    @EnvironmentObject var model: QuizModel
    @State private var isCorrectChord = false
    @State private var chordSelected = false
    @State private var selectedChordIndex: Int?
    let songName: String
    let songIndex: Int
    let tempo: Int
    @State private var currentQuestionIndex = 0
    @State private var selectedChords: [String] = []
    @State private var isIncrementingIndex = false // Flag to track whether index is being incremented, so only one chord is selected
    
    @State private var timer: Timer?
    @State private var isMetronomeOn = false // Track metronome state
    @State private var metronome: Metronome // Declare metronome as a state variable

    // setup model and metronome class
    init(songName: String, songIndex: Int, tempo: Int) {
            self.songName = songName
            self.songIndex = songIndex
            self.tempo = tempo
            // Initialize metronome with the songName
            _metronome = State(initialValue: Metronome(songURL: songName, isMetronomeMode: false, isSongMode: true))
    }

    var body: some View {
        
        VStack {
            if currentQuestionIndex < model.songs[songIndex].chordChanges.count {
                Text("Quiz: \(model.songs[songIndex].name)")
                    .font(.title)
                    .padding()
                
                let chordChange = model.songs[songIndex].chordChanges[currentQuestionIndex]
                Text("What is the \(currentQuestionIndex + 1) chord?")
                    .padding()
                
                ForEach(0..<chordChange.targetChordOptions.count, id: \.self) { index in
                    Button(action: {
                        guard !isIncrementingIndex else { return } // Return if index is already being incremented
                        self.chordSelected = true
                        let selectedChord = chordChange.targetChordOptions[index]
                        self.model.checkChord(selectedChord, against: chordChange.originalChord)
                        self.selectedChords.append(selectedChord)
                        self.selectedChordIndex = index
                        self.isIncrementingIndex = true // Set flag to true
                    
                    }) {
                        Text(chordChange.targetChordOptions[index])
                            .padding()
                            .foregroundColor(.white)
                            .background(
                                index == selectedChordIndex ? (isCorrectChord ? Color.green : Color.red) : Color.black // Set color for selected button
                            )
                            .cornerRadius(10)
                        }
                    .onReceive(model.correctChordSubject) { isCorrect in
                        self.isCorrectChord = isCorrect
                    }
                }
                // upon loadup start metronome and setup for timer to change question
                .onAppear {
                    
                    if !metronome.onAppearFinished { // Start metronome only once
                        metronome.chordDuration = chordChange.durationInBeats
                        metronome.onAppearFinished = true // unsure if needed
                    }
                }
                // signal from metronome to update the view
                .onReceive(metronome.barPublisher) {
                    // Get the index of the next chord change
                    let nextChordIndex = min(self.currentQuestionIndex + 1, self.model.songs[self.songIndex].chordChanges.count - 1)
                    
                    // Get the next chord change
                    let nextChordChange = self.model.songs[self.songIndex].chordChanges[nextChordIndex]
                    
                    // Update the chord duration for the next chord change
                    metronome.chordDuration = nextChordChange.durationInBeats
                    
                    // Update the UI accordingly
                    self.updateQuestionIndex()
                }

                .onDisappear() {
                    metronome.stop()
                }
            } else {
                Text("Quiz completed! \(model.correctCount)/\(model.totalCount)")
            }
        }
        .padding()
        .navigationBarTitle("Quiz", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            isMetronomeOn.toggle()
            if isMetronomeOn {
                metronome.toggleMetronome(bpm: tempo)
            } else {
                metronome.stop()
            }
        }) {
            Text(isMetronomeOn ? "Stop" : "Start")
        })
    }
    
    private func updateQuestionIndex() {
        DispatchQueue.main.async {
            self.currentQuestionIndex += 1 // Increment after the delay specified by the metronome
            self.isCorrectChord = false // Reset isCorrectChord after the timer expires
            self.chordSelected = false
            self.selectedChordIndex = nil // Reset selectedChordIndex to nil at the beginning of each new round
            self.isIncrementingIndex = false // Reset flag to false
        }
    }
}


struct MetronomePageView: View {
    @State private var bpmInput: String = "50"
    @State private var isMetronomePlaying: Bool = false
    @State private var metronome = Metronome(songURL: "metronome_click")

    var body: some View {
        VStack {
            Text("Count: \(metronome.count)")
                            .padding()
            TextField("Enter BPM", text: $bpmInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()

            Button(action: {
                if let bpm = Int(bpmInput) {
                    metronome.toggleMetronome(bpm: bpm)
                    isMetronomePlaying.toggle()
                }
            }) {
                Text(isMetronomePlaying ? "Stop" : "Play")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(10)
                
            }
        }
        .padding()
        .navigationBarTitle(Text("Metronome"), displayMode: .inline)
    }
}

struct PopPageView: View {
    var body: some View {
        Text("Pop")
            .font(.title)
            .foregroundColor(.black)
    }
}

struct RockPageView: View {
    var body: some View {
        Text("Rock")
            .font(.title)
            .foregroundColor(.black)
    }
}

struct CountryPageView: View {
    var body: some View {
        Text("Country")
            .font(.title)
            .foregroundColor(.black)
    }
}

struct AddOwnPageView: View {
    var body: some View {
        Text("Add Your Own")
            .font(.title)
            .foregroundColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

