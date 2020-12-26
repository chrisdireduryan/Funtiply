//
//  ContentView.swift
//  Funtiply
//
//  Created by Chris Direduryan on 25.12.2020.
//

import SwiftUI

var questions = [5, 10, 15, 20, 144]
var nextQuestion:Int = 0
var questionSet = [Int]()
var increment = 0

struct ContentView: View {
    @State private var showSettings: Bool = true
    @State private var multiplicationTable = 5
    @State private var numberOfQuestions = 0
    
    @State private var guess = ""

    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    func startGame() {
        let questionNumber = questions[numberOfQuestions]
        
        for _ in (0..<questionNumber) {
            questionSet.append(Int.random(in: 1...99))
        }
        nextQuestion = questionSet[0]
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
        if Int(guess) == (multiplicationTable * nextQuestion) {
            alertTitle = "Correct"
            alertMessage = "Great job"
        } else {
            alertTitle = "Wrong"
            alertMessage = "Next time bro"
        }
        guess = ""
        showingAlert = true
        increment += 1
        if increment < questionSet.count {
            nextQuestion = questionSet[increment]
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
                    Stepper("\(questions[numberOfQuestions]) questions", value: $numberOfQuestions, in: 0...4)
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
                    Spacer()
                }
                .padding()
                .navigationBarTitle(Text("Welcome to Funtiply"))
            } else {
                VStack(alignment: .leading) {
                    TextField("Your answer", text: $guess, onCommit: checkAnswer)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .keyboardType(.decimalPad)
                        .font(.title)
                    Text("\(increment + 1)\\\(questionSet.count)")
                        .padding(.leading)

                    Spacer()
                }
                .navigationBarTitle(Text("\(multiplicationTable) x \(nextQuestion) ?"))
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
