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
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color(UIColor.systemGray5))
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.systemBackground)))
            VStack(alignment: .leading, spacing: 8) {
                if showIcon {
                    Button(action: {
                        self.isPresented.toggle()
                    }) {
                        HStack{
                            Image(systemName: iconName)
                                .font(.body)
                            if(textLabel == "") {
                                Text("Choose Location")
                            } else {
                                Text(textLabel)
                            }
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                    }.sheet(
                        isPresented: $isPresented
                    ) {
                        print("The sheet has been dismissed")
                        print(location)
                    } content: {
                        LocationListView(isPresented: self.$isPresented, location: self.$location, region: self.$region)
                    }
                }
            }.padding(5)
        }
//        .cornerRadius(12)
        .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
        .fixedSize(horizontal: false, vertical: true)
//        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
    }
}

