//
//  AnswerField.swift
//  Funtiply
//
//  Created by Chris Direduryan on 26.12.2020.
//

import SwiftUI

struct AnswerField: View {

    @Binding var text: String
    var onCommit: () -> ()
    
    var body: some View {
        TextField("Your answer", text: $text, onCommit: onCommit)
            .padding()
            .foregroundColor(.white)
            .background(Color.black)
            .keyboardType(.decimalPad)
            .font(.title)
    }
}
