//
//  ContentView.swift
//  Funtiply
//
//  Created by Chris Direduryan on 25.12.2020.
//

import SwiftUI

var questionCount = [5, 10, 15, 20, 99]
var questions = [Question]()
var currentQuestion = questions[0]
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
        
        for number in (0..<questionNumber) {
            questions.append(Question(question: "What is \(multiplicationTable) times \(number)", answer: multiplicationTable * number))
        }
        questions.shuffle()
        print(questions)
    }
    
    func gameOver() {
        showingAlert = true
        alertTitle = "Game Over"
        alertMessage = "Your score: xx"
        showSettings.toggle()
        questionIncrement = 0

    }
    
    func quitGame() {
        showingAlert = true
        alertTitle = "Leave Game"
        alertMessage = "You still have some moves"
        showSettings.toggle()
        questionIncrement = 0

    }
    
    func checkAnswer() {
        if Int(guess) == (questions[questionIncrement].answer) {
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

        if questionIncrement < questions.count {
            currentQuestion = questions[questionIncrement]
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
                    Text("\(questions[questionIncrement].question)")
                        .padding(.leading)

                    Spacer()
                }
                .navigationBarTitle(Text("\(currentQuestion.question)"))
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
