//
//  Settings.swift
//  Funtiply
//
//  Created by Chris Direduryan on 25.12.2020.
//

import SwiftUI

var questions = ["5", "10", "15", "20", "All"]

struct Settings: View {
    @State private var multiplicationTable = 5
    @State private var numberOfQuestions = 0
    
    @State private var guess = ""
    @State private var showingAlert: Bool = false
    @State private var isHidden: Bool = false
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            Stepper("\(multiplicationTable) times table", value: $multiplicationTable, in: 1...12)
            Stepper("\(questions[numberOfQuestions]) questions", value: $numberOfQuestions, in: 0...4)
//            TextField("Your answer", text: $guess)
//                .padding()
//                .border(Color.secondary, width: 1)
            Button(action: {
                // some code
            }, label: {
                Text("Start Game")
            })
            .padding()
            .frame(width: .infinity)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8.0)
            Spacer()
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
            
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
