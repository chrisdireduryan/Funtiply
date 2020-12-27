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
            .font(.title)
            .background(Color(red: 74 / 255, green: 21 / 255, blue: 25 / 255))
    }
}
