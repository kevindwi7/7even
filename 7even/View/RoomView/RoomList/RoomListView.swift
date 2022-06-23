//
//  RoomListView.swift
//  7even
//
//  Created by Inez Amanda on 23/06/22.
//

import SwiftUI

struct RoomListView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    LazyVStack(alignment: .leading) {
                        Text("Find a Room").bold()
                        Group {
                            Text("that ").bold()
                            +
                            Text("FITS").bold().foregroundColor(.mint)
                            +
                            Text("Your").bold()
                        }
                        Text("Sporting Preference").bold()
                    }
                    .font(.largeTitle)
//                    .padding(EdgeInsets(top: -50, leading: -10, bottom: 0, trailing: 0))
                }
                
                .background(Color.red)
                Spacer()
            }
            
            .navigationBarTitleDisplayMode(.large)
            .toolbar { // <2>
                ToolbarItem(placement: .navigationBarLeading) { //
                    VStack {
                        Text("Find a Room")
                            .font(.largeTitle)
                            .bold()
//                        Text("that") + Text("Fits")
//                            .font(.largeTitle)
//                            .bold()
//                        Text("Find a Room")
//                            .font(.largeTitle)
//                            .bold()
                    }
                }
            }
        }
    }
}

struct RoomListView_Previews: PreviewProvider {
    static var previews: some View {
        RoomListView()
            .previewDevice("iPhone 13")
    }
}
