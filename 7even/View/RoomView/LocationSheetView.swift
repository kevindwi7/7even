//
//  LocationSheetView.swift
//  7even
//
//  Created by Inez Amanda on 22/06/22.
//

import SwiftUI

struct LocationSheetView: View {
    
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
                        Image(systemName: "mappin")
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.name)
                                .bold()
                                .font(.title3)
                            Text(item.address.uppercased())
                                .font(.footnote)
                        }.padding(5)
                    }
                }
            }
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
