//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Isaac Kim on 3/31/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gameCount = 1
    @State private var showingResults = false
    
    
    @State private var countries = allCountries.shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
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
                    .foregroundColor(.white)
                    .font(.largeTitle.weight(.bold))
                
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
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
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
