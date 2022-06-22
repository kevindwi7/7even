//
//  SportPreferenceSheetView.swift
//  7even
//
//  Created by Inez Amanda on 22/06/22.
//

import SwiftUI

struct SportPreferenceSheetView: View {
    @Binding var isPresented: Bool
    @Binding var preference: String
    var type = ""
    
    var body: some View {
        NavigationView {
            List (PREFERENCETYPE.getPreferenceFromType(type: type)) { item in
                Button(action: {
                    self.preference = item.rawValue
                    print(preference)
                    self.isPresented = false
                }) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.rawValue)
                            .font(.title3)
                    }.padding(5)
                }
            }
            .navigationBarTitle(Text("Select"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                    print("The sheet has been dismissed")
                    self.isPresented = false
            }) {
                Image(systemName: "chevron.left")
                .font(.body)
            })
        }
    }
}

