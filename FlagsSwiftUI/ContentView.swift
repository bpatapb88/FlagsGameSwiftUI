//
//  ContentView.swift
//  FlagsSwiftUI
//
//  Created by Semen Simanov on 02.09.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["UK", "USA", "Bangladesh", "Germany", "Argentina", "Brazil", "Canada", "Greece", "Russia","Sweden"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showScore = false
    @State private var scoreTitle = ""
    
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30){
                VStack{
                    Text("Choose a flag:")
                        .foregroundColor(.white)
                        .font(.headline)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3){number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showScore = true
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 250, height: 125)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
            }
            
        } .alert(isPresented: $showScore){
            Alert(title: Text(scoreTitle), message: Text("Score: \(score)"), dismissButton: .default(Text("Next")){
                self.askQuestion()
            })
        }
        
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct!"
            score += 1
            
        }else{
            scoreTitle = "Wrong! This flag \(countries[number])"
            score -= 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
