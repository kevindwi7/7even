//
//  LocationSheetView.swift
//  7even
//
//  Created by Inez Amanda on 22/06/22.
//

import SwiftUI

struct LocationListView: View {
    
    @State private var searchText = ""
    @Binding var isPresented: Bool
    @Binding var location: Location
    @Binding var region: String
    
    var body: some View {
        NavigationView {
            List (Location.locationList.filter { $0.region == region }, id: \.self){ item in
                Button(action: {
                    location = item
                    self.isPresented = false
                }) {
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 37)
                            .foregroundColor(Color.mint)
                            
                        VStack(alignment: .leading, spacing: 5) {
                            Text(item.name)
                                .font(.subheadline)
                            Text(item.address.uppercased())
                                .font(.caption)
                                .foregroundColor(Color(UIColor.systemGray))
                        }.padding(5)
                    }
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always),prompt: "Search")
            .navigationBarTitle(Text("Choose Location"), displayMode: .inline)
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
