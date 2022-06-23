//
//  RoomPreferenceSheetView.swift
//  7even
//
//  Created by Inez Amanda on 23/06/22.
//

import SwiftUI

struct SingleSelectPreferenceListView: View {
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
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always),prompt: "Search")
                .navigationBarTitle(Text("Sports Name"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    print("The sheet has been dismissed")
                    self.isPresented = false
                }) {
                    Image(systemName: "chevron.left")
                        .font(.body)
                        .foregroundColor(Color.mint)
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
                .navigationBarTitle(Text("Region"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    print("The sheet has been dismissed")
                    self.isPresented = false
                }) {
                    Image(systemName: "chevron.left")
                        .font(.body)
                        .foregroundColor(Color.mint)
                })
            } else if (type == "sex") {
                VStack(alignment: .center) {
                    VStack {
                        
                        Text("Select gender who able to join the room")
                            .font(.subheadline)
                    }.padding(EdgeInsets(top: 50, leading: 0, bottom: 20, trailing: 0))
                    
                    
                    HStack(spacing: 100) {
                        ForEach (sexes, id: \.self) { item in
                            Button(action: {
                                self.preference = item.name
                                print(preference)
                                self.isPresented = false
                            }) {
                                VStack(spacing: 10) {
                                    Image(systemName: item.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40)
                                        .background(Color.red)

                                    Text(item.name)
                                        .font(.body)
                                        .foregroundColor(Color.primary)
                                }
                                .padding(5)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(Color(UIColor.systemGray3), lineWidth: 1)
                                        .frame(width: 90, height: 90)
                                )
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                }
                .navigationBarTitle(Text("Sex"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    print("The sheet has been dismissed")
                    self.isPresented = false
                }) {
                    Image(systemName: "chevron.left")
                        .font(.body)
                        .foregroundColor(Color.mint)
                })
            } else if (type == "levelOfPlay") {
                VStack(alignment: .center) {
                    VStack {
                        Text("Select type of competitive level")
                            .font(.subheadline)
                    }.padding(EdgeInsets(top: 50, leading: 0, bottom: 20, trailing: 0))
                    
                    HStack(spacing: 100) {
                        ForEach (level, id: \.self) { item in
                            Button(action: {
                                self.preference = item.name
                                print(preference)
                                self.isPresented = false
                            }) {
                                VStack(alignment: .center, spacing: 8) {
                                    Image(systemName: item.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 37)
                                        .background(Color.red)

                                    Text(item.name)
                                        .font(.body)
                                        .foregroundColor(Color.primary)
                                }
                                .padding(5)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(Color(UIColor.systemGray3), lineWidth: 1)
                                        .frame(width: 104, height: 104)
                                )
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                }
                .navigationBarTitle(Text("Level Of Play"), displayMode: .inline)
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
