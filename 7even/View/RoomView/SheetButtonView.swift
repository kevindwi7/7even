//
//  ButtonModalView.swift
//  7even
//
//  Created by Inez Amanda on 21/06/22.
//

import SwiftUI

struct SheetButtonView: View {
    
    var showModalButton = false
    @State var type = ""
    @Binding var textLabel: String
    @State var isPresented = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color(UIColor.systemGray5))
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.systemBackground)))
            VStack(alignment: .leading, spacing: 8) {
                if showModalButton {
                    Button(action: {
                        self.isPresented.toggle()
                    }) {
                        HStack {
                            if(textLabel == "") {
                                if(type == "sport"){
                                    Text("Sport's Name")
                                        .foregroundColor(.primary)
                                }
                                else if (type == "region") {
                                    Text("Region")
                                        .foregroundColor(.primary)
                                }
                            } else {
                                Text(textLabel)
                                    .foregroundColor(.primary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                            .font(.headline)
                            
                        }
                    }.sheet(
                        isPresented: $isPresented
                    ) {
                        print("The sheet has been dismissed")
                    } content: {
                        SingleSelectPreferenceListView(isPresented: $isPresented, preference: self.$textLabel, type: type)
                    }
                    .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                }
            }.padding(5)
        }
//        .cornerRadius(12)
        .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
        .fixedSize(horizontal: false, vertical: true)
//        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
    }
}
