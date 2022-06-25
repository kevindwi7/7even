//
//  MultipleSelectPreferenceListView.swift
//  7even
//
//  Created by Inez Amanda on 23/06/22.
//

import SwiftUI

struct MultipleSelectPreferenceListView: View {
    
    @Binding var isPresented: Bool
    @Binding var preference: [String]
    @State var isChecked = false
    var type = ""
    
    
    var body: some View {
        NavigationView {
            if (type == "age") {
                List (ages, id: \.self) { item in
                    // SELECTED
                    Button(action: {
                        for index in preference {
                            if(index == item.name) {
                                // MARK BUTTON AS CHECKED
                                if let matchingIndex = ages.firstIndex(where: { $0.id == item.id }) {
                                    ages[matchingIndex].isChecked = true
                                }
                            }
                        }

        
                        if let matchingIndex = ages.firstIndex(where: { $0.id == item.id }) {
                            ages[matchingIndex].isChecked.toggle()
                            
                            if(ages[matchingIndex].isChecked == true) {
                                self.preference.append(item.name)
                            } else {
                                let match = self.preference.firstIndex(where: { $0 == item.name})
                                self.preference.remove(at: match ?? 0)
                            }
                        }
                        print(preference)
                    }){
                        HStack {
                            Image(systemName: item.image)
                            Text(item.name)
                                .font(.title3)
                                .foregroundColor(item.isChecked == true ? Color.mint : Color.primary)
                            Spacer()
                            if(item.isChecked == true){
                                Image(systemName: "checkmark")
                                    .font(.headline)
                                    .foregroundColor(Color.mint)
                            }
                        }
                    }
                }
                .navigationBarTitle(Text("Select Age"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    print("The sheet has been dismissed")
                    self.isPresented = false
                }) {
                    Image(systemName: "chevron.left")
                        .font(.body)
                        .foregroundColor(Color.mint)
                })
            }
        }
    }
}

