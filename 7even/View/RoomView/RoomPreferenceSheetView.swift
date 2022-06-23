//
//  RoomPreferenceSheetView.swift
//  7even
//
//  Created by Inez Amanda on 23/06/22.
//

import SwiftUI

struct RoomPreferenceSheetView: View {
    @Binding var isPresented: Bool
    @Binding var preference: String
    @State private var searchText = ""
    var type = ""
    
    var body: some View {
        NavigationView {
            if (type == "sport") {
                List (sports, id: \.self) { item in
                    Button(action: {
                        self.preference = item.name
                        print(preference)
                        self.isPresented = false
                    }){
                        HStack {
                            Image(systemName: item.image)
                            Text(item.name)
                                .font(.title3)
                        }
                    }
                }
                .navigationBarTitle(Text("Select Sport"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    print("The sheet has been dismissed")
                    self.isPresented = false
                }) {
                    Image(systemName: "chevron.left")
                        .font(.body)
                })
            } else if (type == "age") {
                List (ages, id: \.self) { item in
                    Button(action: {
                        self.preference = item.name
                        print(preference)
                        self.isPresented = false
                    }){
                        HStack {
                            Image(systemName: item.image)
                            Text(item.name)
                                .font(.title3)
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
                })
            } else if (type == "region"){
                List (REGION.allCases, id: \.rawValue) { item in
                    Button(action: {
                        self.preference = item.rawValue
                        print(preference)
                        self.isPresented = false
                    }){
                        HStack {
                            Text(item.rawValue)
                                .font(.title3)
                        }
                    }
                }
                .navigationBarTitle(Text("Select \(type)"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    print("The sheet has been dismissed")
                    self.isPresented = false
                }) {
                    Image(systemName: "chevron.left")
                        .font(.body)
                })
            } else if (type == "sex") {
                VStack {
                    HStack(alignment: .top) {
                        ForEach (sexes, id: \.self) { item in
                            Button(action: {
                                self.preference = item.name
                                print(preference)
                                self.isPresented = false
                            }) {
                                VStack(alignment: .center, spacing: 8) {
                                    Image(systemName: "mappin")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 50)

                                    Text("\(item.name) Only")
                                        .font(.title3)
                                }.padding(5)
                                if ( item != sexes.last) {
                                    Spacer()
                                }
                            }
                        }
                    }.padding(50)
                    Spacer()
                }
                .navigationBarTitle(Text("Select \(type)"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    print("The sheet has been dismissed")
                    self.isPresented = false
                }) {
                    Image(systemName: "chevron.left")
                        .font(.body)
                })
            } else if (type == "levelOfPlay") {
                VStack {
                    HStack(alignment: .top) {
                        ForEach (level, id: \.self) { item in
                            Button(action: {
                                self.preference = item.name
                                print(preference)
                                self.isPresented = false
                            }) {
                                VStack(alignment: .center, spacing: 8) {
                                    Image(systemName: "mappin")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 50)

                                    Text(item.name)
                                        .font(.title3)
                                }.padding(5)
                                if ( item != level.last) {
                                    Spacer()
                                }
                            }
                        }
                    }.padding(50)
                    Spacer()
                }
                .navigationBarTitle(Text("Select \(type)"), displayMode: .inline)
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
}
