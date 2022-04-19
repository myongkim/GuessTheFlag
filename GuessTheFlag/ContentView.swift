//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Isaac Kim on 3/31/22.
//

import SwiftUI

// objective
//When you tap a flag, make it spin around 360 degrees on the Y axis.
//Make the other two buttons fade out to 25% opacity.
//Add a third effect of your choosing to the two flags the user didn’t choose – maybe make them scale down? Or flip in a different direction? Experiment!
///
struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gameCount = 1
    @State private var showingResults = false
    
    @State private var selectedFlag = -1
    
    
    
    @State private var countries = allCountries.shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green:0.2, blue:0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            //            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .title()
                
                VStack{
                    VStack(spacing: 15) {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            // flag was tapped
                         
                            flagTapped(number)
                            
                            
                            
                        } label: {
                           FlagImage(name: countries[number])
                                

                                
                            
                        }
                        .rotation3DEffect(.degrees(selectedFlag == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.25)
//                        .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.75)
//                        .saturation(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0)
                        .blur(radius: selectedFlag == -1 || selectedFlag == number ? 1 : 5)

                        .animation(.default, value: selectedFlag)
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                        
                        
                    }
                    
                   
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
                
            } message: {
                Text("Your score is \(score)")
            }
            .alert("Game Over", isPresented: $showingResults) {
                Button("Start Again", action: newGame)
                
            } message: {
                Text("Your final score was \(score)")
            }
        
        
    }
    func flagTapped(_ number: Int) {
        selectedFlag = number
        
        
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
          
        } else {
            let needsThe = ["UK", "US"]
            let theirAnswer = countries[number]
            
                if needsThe.contains(theirAnswer) {
                    scoreTitle = "Wrong! That's the flag of the \(theirAnswer)"
                } else {
                    scoreTitle = "Wrong! That's the flag of \(theirAnswer)"
                }
                
                if score > 0 {
                    score -= 1
                }
            }
        
        if gameCount == 8 {
            showingResults = true
        } else {
            showingScore = true
        }

    }
        
    
    
    func askQuestion() {
        countries.remove(at: correctAnswer)
        countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
        gameCount += 1
        selectedFlag = -1
    }
    
    func newGame() {
        gameCount = 0
        score = 0
        countries = Self.allCountries
        askQuestion()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
