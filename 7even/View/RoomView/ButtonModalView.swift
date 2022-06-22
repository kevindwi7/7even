//
//  ButtonModalView.swift
//  7even
//
//  Created by Inez Amanda on 21/06/22.
//

import SwiftUI

//extension ForEach where Data.Element: Hashable, ID == Data.Element, Content: View {
//    init(values: Data, content: @escaping (Data.Element) -> Content) {
//        self.init(values, id: \.self, content: content)
//    }
//}

struct ButtonModalView: View {
    var textLabel = "Halo"
    var showModalButton = false
    var showIcon = false
    var iconName = "mappin"
    var type = ""
    @State var isPresented = false

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
                        } content: {
                            Text("halo")
                        }
                    }
                    Text(textLabel)
                    Spacer()
                    if showModalButton {
                        Button(action: {
                            self.isPresented.toggle()
                        }) {
                            Image(systemName: "chevron.right")
                            .font(.body)
    //                        NavigationLink("Cell title", destination: EmptyView())
                        }.sheet(
                            isPresented: $isPresented
                        ) {
                            print("The sheet has been dismissed")
                        } content: {
                            if(type == "sport"){
                                ForEach(SPORT.allCases, id: \.rawValue) { item in
                                    Text(item.rawValue)
                                }
                            }
                            else if(type == "sex"){
                                ForEach(SEX.allCases, id: \.rawValue) { item in
                                    Text(item.rawValue)
                                }
                            }
                            else if(type == "age"){
                                ForEach(AGE.allCases, id: \.rawValue) { item in
                                    Text(item.rawValue)
                                }
                            }
                            else if(type == "level"){
                                ForEach(LEVEL.allCases, id: \.rawValue) { item in
                                    Text(item.rawValue)
                                }
                            }
                        }
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

struct ButtonModalView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonModalView(showIcon: true)
    }
}
