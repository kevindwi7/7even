//
//  RoomListView.swift
//  7even
//
//  Created by Inez Amanda on 23/06/22.
//

import SwiftUI

struct RoomListView: View {
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 75)),
        GridItem(.adaptive(minimum: 75)),
        GridItem(.adaptive(minimum: 75))
    ]
    
    private let adaptiveColumns2 = [
        GridItem(.adaptive(minimum: 142)),
        GridItem(.adaptive(minimum: 142))
    ]
    
    var body: some View {
        TabView {
            NavigationView {
                VStack(alignment: .leading) {
                    // TITLE
                    LazyVStack(alignment: .leading) {
                        Text("Find a Room").bold()
                        Group {
                            Text("that ").bold()
                            +
                            Text("FITS").bold().foregroundColor(.mint)
                            +
                            Text(" Your").bold()
                        }
                        Text("Sporting Preference").bold()
                    }
                    .font(.title)
                    .padding(EdgeInsets(top: -94, leading: 16, bottom: 20, trailing: 0))
                    
                    // FILTER
                    ScrollView(.vertical) {
                        LazyVStack(alignment: .leading){
                            HStack {
                                LazyVGrid(columns: adaptiveColumns, spacing: 10) {
                                    ForEach(sports, id: \.self) { sport in
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color(UIColor.systemGray6))
                                                .frame(width: 80, height: 22)
                                            
                                            Text(sport.name)
                                                .font(.caption2)
                                        }
                                        .onTapGesture {
                                            print("Tap \(sport.name)")
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                                
                                Group {
                                    VStack{
                                        Text("See All Filters")
                                            .font(.caption)
                                        Image(systemName: "globe")
                                            .resizable()
        //                                    .scaledToFit()
                                            .frame(width: 20)
                                    }
                                    .frame(width: 80)
                                    .onTapGesture {
                                        print("Open Filter Sheet")
                                    }
                                }.padding(.horizontal)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                    
                        VStack(alignment: .leading) {
                            Text("Rooms You Might Like")
                                .bold()
                                .font(.title2)
                                .padding(.horizontal)
                             
                            LazyVGrid(columns: adaptiveColumns2, alignment: .center, spacing: 5) {
                                ForEach(sports, id: \.self) { index in
                                    NavigationLink(destination: Text("Detail Room"), label: {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color(UIColor.systemGray6))
                                                .frame(width: 168, height: 127)
                                                
                                            Text("Room \(index.name)")
                                        }
                                        .onTapGesture {
                                            print("Tap \(index.name)")
                                        }
                                    })
                                    .padding(.vertical, 5)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                            
                        } //VSTACK
                         
                        VStack(alignment: .leading) {
                            Text("Other Rooms")
                                .bold()
                                .font(.title2)
                                .padding(.horizontal)
                             
                            LazyVGrid(columns: adaptiveColumns2, alignment: .center, spacing: 5) {
                                ForEach(sports, id: \.self) { index in
                                    NavigationLink(destination: Text("Detail Room"), label: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color(UIColor.systemGray6))
                                                    .frame(width: 168, height: 127)
                                                    
                                                Text("Room \(index.name)")
                                            }
                                            .onTapGesture {
                                                print("Tap \(index.name)")
                                            }
                                    })
                                    .padding(.vertical, 5)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                            
                        } //VSTACK
                    } // SCROLLVIEW
                } //VSTACK
            } //NAVIGATIONVIEW
        } //TABVIEW
    } //BODY
}

struct RoomListView_Previews: PreviewProvider {
    static var previews: some View {
        RoomListView()
            .previewDevice("iPhone 13")
    }
}
