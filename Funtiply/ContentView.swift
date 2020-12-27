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
        ZStack {
            Color(red: 246 / 255, green: 239 / 255, blue: 232 / 255)
                .ignoresSafeArea()

            VStack {
                if showSettings {
                    VStack {
                        Text("Welcome to Funtiply")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        VStack {
                            Text("Choose times table and \n start the game")
                                .multilineTextAlignment(.center)
                            HStack {
                                ForEach (1..<5) { number in
                                    Button("\(number)") {
                                        multiplicationTable = number
                                        showSettings.toggle()
                                        startGame()
                                    }
                                    .foregroundColor(.white)
                                    .frame(width: 56, height: 56)
                                    .background(Color(red: 74 / 255, green: 21 / 255, blue: 25 / 255))
                                    .cornerRadius(28.0)
                                }
                            }
                            .padding()
                            HStack {
                                ForEach (5..<9) { number in
                                    Button("\(number)") {
                                        multiplicationTable = number
                                        showSettings.toggle()
                                        startGame()
                                    }
                                    .foregroundColor(.white)
                                    .frame(width: 56, height: 56)
                                    .background(Color(red: 74 / 255, green: 21 / 255, blue: 25 / 255))
                                    .cornerRadius(28.0)

                                }
                            }
                            .padding()
                            HStack {
                                ForEach (9..<13) { number in
                                    Button("\(number)") {
                                        multiplicationTable = number
                                        showSettings.toggle()
                                        startGame()
                                    }
                                    .foregroundColor(.white)
                                    .frame(width: 56, height: 56)
                                    .background(Color(red: 74 / 255, green: 21 / 255, blue: 25 / 255))
                                    .cornerRadius(28.0)
                                }
                            }
                            .padding()
                        }
                        Spacer()
                        Stepper("\(questionCount[numberOfQuestionsIndex]) questions", value: $numberOfQuestionsIndex, in: 0...4)

                        if score > 0 {
                            Text("Your last score: \(score)")
                                .padding()
                        }
                        Spacer()
                    }
                    .padding()
                    .foregroundColor(Color(red: 74 / 255, green: 21 / 255, blue: 25 / 255))
                } else {
                    VStack(alignment: .leading) {
                        AnswerField(text: $guess, onCommit: checkAnswer)
                        Text("\(questionIncrement + 1)\\\(questions.count) - \(currentQuestion.question)")                        
                        Button(action: { quitGame() }, label: {
                            HStack {
                                Text("Quit")
                                Image(systemName: "xmark.circle")
                            }})

                    }

                }
            }

            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
