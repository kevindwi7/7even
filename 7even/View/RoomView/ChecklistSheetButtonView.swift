//
//  ChecklistSheetButtonView.swift
//  7even
//
//  Created by Inez Amanda on 23/06/22.
//

import SwiftUI

struct ChecklistSheetButtonView: View {
    
    var showModalButton = false
    @State var type = ""
    @Binding var textLabel: [String]
    @State var isPresented = false
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    if showModalButton {
                        if(textLabel.contains("") && textLabel.count == 1) {
                            if (type == "age") {
                                Text("Age")
                            }
                        }
                        else {
                            ForEach(self.textLabel, id: \.self) { item in
                                if(!item.contains("")) {
                                    Text(item)
                                }
                                
                            }
                        }
                        Spacer()
                        Button(action: {
                            self.isPresented.toggle()
                            print("ini \(textLabel)")
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.headline)
                                .foregroundColor(Color.mint)
                        }.sheet(
                            isPresented: $isPresented
                        ) {
                            print("The sheet has been dismissed")
                        } content: {
                            Text("")
                            MultipleSelectPreferenceListView(isPresented: $isPresented, preference: self.$textLabel, type: type)
                        }
                    }
                }.padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
            }
            .padding(5)
            
        }
        .cornerRadius(12)
        .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
        .fixedSize(horizontal: false, vertical: true)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
    }
}
