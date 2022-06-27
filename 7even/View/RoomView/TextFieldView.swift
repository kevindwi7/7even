//
//  TextFieldView.swift
//  7even
//
//  Created by Inez Amanda on 21/06/22.
//

import SwiftUI

struct TextFieldView: View {
    var textLabel = "Halo"
    @Binding var inputNumber: String
    @FocusState.Binding var inputIsFocused: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color(UIColor.systemGray5))
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.systemBackground)))
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    TextField(textLabel, text: $inputNumber)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                }.padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
            }.padding(5)
        }
//        .cornerRadius(12)
        .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
        .fixedSize(horizontal: false, vertical: true)
//        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
    }
}

