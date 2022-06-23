//
//  ButtonModalView.swift
//  7even
//
//  Created by Inez Amanda on 21/06/22.
//

import SwiftUI

struct LocationButtonView: View {
    
    var showModalButton = false
    var showIcon = false
    var iconName = "mappin"
    var type = ""
    
    @Binding var textLabel: String
    @State var isPresented = false
    @Binding var location: Location
    @Binding var region: String

    var body: some View {
        ZStack {
            Color(.systemBackground)
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    if showIcon {
                        Button(action: {
                            self.isPresented.toggle()
                        }) {
                            Image(systemName: iconName)
                                .font(.body)
                        }.sheet(
                            isPresented: $isPresented
                        ) {
                            print("The sheet has been dismissed")
                            print(location)
                        } content: {
                            LocationListView(isPresented: self.$isPresented, location: self.$location, region: self.$region)
                        }
                        
                        if(textLabel == "") {
                            Text("Choose Location")
                        } else {
                            Text(textLabel)
                        }
                        Spacer()
                    }
                }.padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
            }.padding(5)
        }
        .cornerRadius(12)
        .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
        .fixedSize(horizontal: false, vertical: true)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
    }
}

