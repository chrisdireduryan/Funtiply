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
//        print(questionSet)
    }
    
    var body: some View {
        VStack {
            if showSettings {
                Text("Funtiply")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Divider()
                Text("Please choose the times table and number of questions")

                Stepper("\(multiplicationTable) times table", value: $multiplicationTable, in: 1...12)
                Stepper("\(questions[numberOfQuestions]) questions", value: $numberOfQuestions, in: 0...4)
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
            } else {
                Text("What is \(multiplicationTable) times \(nextQuestion)")
                TextField("Your answer", text: $guess)
                Spacer()
                Button("Answer") {
                    if Int(guess) == (multiplicationTable * nextQuestion) {
                        alertTitle = "Correct"
                        alertMessage = "Great job"
                    } else {
                        alertTitle = "Wrong"
                        alertMessage = "Next time bro"
                    }
                    showingAlert.toggle()
                    increment += 1
                    nextQuestion = questionSet[increment]
                }
                .foregroundColor(.white)
                .frame(width: 160, height: 60)
                .background(Color.blue)
                .cornerRadius(8.0)
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
