//
//  ContentView.swift
//  Funtiply
//
//  Created by Chris Direduryan on 25.12.2020.
//

import SwiftUI

var questionCount = [5, 10, 15, 20, 144]
var currentQuestionIndex = 0
var allQuestions = [Int]()
var questionIncrement = 0
var score = 0

struct ContentView: View {
    @State private var showSettings = true
    @State private var multiplicationTable = 5
    @State private var numberOfQuestionsIndex = 0
    
    @State private var guess = ""

    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    func startGame() {
        let questionNumber = questionCount[numberOfQuestionsIndex]
        
        for _ in (0..<questionNumber) {
            allQuestions.append(Int.random(in: 1...99))
        }
        currentQuestionIndex = allQuestions[0]
    }
    
    func gameOver() {
        showingAlert = true
        alertTitle = "Game Over"
        alertMessage = "Your score: xx"
        showSettings.toggle()
    }
    
    func quitGame() {
        showingAlert = true
        alertTitle = "Leave Game"
        alertMessage = "You still have some moves"
        showSettings.toggle()
    }
    
    func checkAnswer() {
        if Int(guess) == (multiplicationTable * currentQuestionIndex) {
            alertTitle = "Correct"
            alertMessage = "Great job"
        } else {
            alertTitle = "Wrong"
            alertMessage = "Next time bro"
        }
        guess = ""
        score += 1
        showingAlert = true
        questionIncrement += 1
        if questionIncrement < allQuestions.count {
            currentQuestionIndex = allQuestions[questionIncrement]
        } else {
            gameOver()
        }
    }
    
    var body: some View {
        NavigationView {
            if showSettings {
                VStack {
                    Spacer()
                    Stepper("\(multiplicationTable) times table", value: $multiplicationTable, in: 1...12)
                    Stepper("\(questionCount[numberOfQuestionsIndex]) questions", value: $numberOfQuestionsIndex, in: 0...4)
                    Spacer()
                    Button(action: {
                        showSettings.toggle()
                        startGame()
                    }, label: {
                        Text("Start Game")
                    })
                    .foregroundColor(.white)
                    .frame(width: 160, height: 60)
                    .background(Color.blue)
                    .cornerRadius(8.0)
                    if score > 0 {
                        Text("Your score: \(score)")
                            .padding()
                    }
                    Spacer()
                }
                .padding()
                .navigationBarTitle(Text("Welcome to Funtiply"))
            } else {
                VStack(alignment: .leading) {
                    AnswerField(text: $guess, onCommit: checkAnswer)
                    Text("\(questionIncrement + 1)\\\(allQuestions.count)")
                        .padding(.leading)

                    Spacer()
                }
                .navigationBarTitle(Text("\(multiplicationTable) x \(currentQuestionIndex) ?"))
                .navigationBarItems(
                    trailing: Button(action: { quitGame() }, label: {
                        HStack {
                            Text("Quit")
                            Image(systemName: "xmark.circle")
                        }})
                )
            }
            Spacer()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
