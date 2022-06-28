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
                .listStyle(.plain)
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
                .listStyle(.plain)
                .navigationBarTitle(Text("Region"), displayMode: .inline)
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
