//
//  TextFieldView.swift
//  7even
//
//  Created by Inez Amanda on 21/06/22.
//

import SwiftUI

struct TextFieldView: View {
    var textLabel = "Enter"
    var isTextEditor = false
    var isText = false
    @Binding var text: String
    @FocusState.Binding var inputIsFocused: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color(UIColor.systemGray5))
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.systemBackground)))
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    if(isTextEditor) {
                        TextEditor(text: $text)
                            .frame(height: 90)
                            .focused($inputIsFocused)
                    } else if (isText){
                        TextField(textLabel, text: $text)
                            .focused($inputIsFocused)
                    } else {
                        TextField(textLabel, text: $text)
                            .keyboardType(.decimalPad)
                            .focused($inputIsFocused)
                    }
                }.padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
            }.padding(isTextEditor == true ? 0 : 5)
        }
        .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
        .fixedSize(horizontal: false, vertical: true)
    }
}

