//
//  SportPreferenceSheetView.swift
//  7even
//
//  Created by Inez Amanda on 22/06/22.
//

import SwiftUI

struct RoomPreferenceSheetView: View {
    @Binding var isPresented: Bool
    @Binding var preference: String
    @State private var searchText = ""
    var type = ""
    
    var body: some View {
        NavigationView {
            Group {
                if (type == "sport" || type == "age" || type == "region") {
                    List (PREFERENCETYPE.getPreferenceFromType(type: type)) { item in
                        Button(action: {
                            self.preference = item.rawValue
                            print(preference)
                            self.isPresented = false
                        }) {
                            HStack() {
                                if (type != "region") {
                                    Image(systemName: "mappin")
                                }
                                Text(item.rawValue)
                                    .font(.title3)
                            }
                        }
                    }
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
                }
                else if (type == "sex" || type == "levelOfPlay") {
                    VStack {
                        HStack(alignment: .top) {
                            ForEach (PREFERENCETYPE.getPreferenceFromType(type: type)) { item in
                                Button(action: {
                                    self.preference = item.rawValue
                                    print(preference)
                                    self.isPresented = false
                                }) {
                                    VStack(alignment: .center, spacing: 8) {
                                            Image(systemName: "mappin")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 50)
                                        
                                            Text(item.rawValue)
                                                .font(.title3)
                                    }.padding(5)
                                    if ( item != PREFERENCETYPE.getPreferenceFromType(type: type).last) {
                                        Spacer()
                                    }
                                }
                            }
                        }.padding(50)
                        Spacer()
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
        }
    }
}

