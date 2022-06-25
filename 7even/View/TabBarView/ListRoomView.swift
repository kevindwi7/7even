//
//  ListRoomView.swift
//  7even
//
//  Created by Kevin  Dwi on 24/06/22.
//

import SwiftUI
import CloudKit

struct ListRoomView: View {
    
    private let filterAdaptiveColumns = [
        GridItem(.adaptive(minimum: 75)),
        GridItem(.adaptive(minimum: 75)),
        GridItem(.adaptive(minimum: 75))
    ]
    
    private let roomAdaptiveColumns = [
        GridItem(.adaptive(minimum: 142)),
        GridItem(.adaptive(minimum: 142))
    ]
    
    private let roomCategory = [
        "Rooms You Might Like",
        "Other Rooms"
    ]
    
    @State var selectedRoom: String?
    let defaults = UserDefaults.standard
    
    var body: some View {
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
                            LazyVGrid(columns: filterAdaptiveColumns, spacing: 10) {
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
                
                    ForEach(roomCategory, id: \.self){ item in
                        VStack(alignment: .leading) {
                            Text(item)
                                .bold()
                                .font(.title2)
                                .padding(.horizontal)
                             
                            if(item == "Rooms You Might Like" ) {
                                if(!defaults.bool(forKey: "login")){
                                    LazyVStack{
                                        Text("Sign up to manage your preferences")
                                        NavigationLink(destination: LoginView(), label: {
                                            Text("Here")
                                                .bold()
                                                .foregroundColor(.mint)
                                                .underline()
                                        })
                                    }.padding(.vertical, 25)
                                } else {
                                    LazyVGrid(columns: roomAdaptiveColumns, alignment: .center, spacing: 5) {
                                        ForEach(sports, id: \.self) { index in
                                            ListRoomCardView(sport: index)
                                            
                                            if (index == sports.last) {
                                                ListRoomCardView(sport: index, isAddRoomButton: true)
                                            }
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal)
                                }
                            } else {
                                    LazyVGrid(columns: roomAdaptiveColumns, alignment: .center, spacing: 5) {
                                        ForEach(sports, id: \.self) { index in
                                            ListRoomCardView(sport: index)
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal)
                            }

                        } //VSTACK
                    }
                } // SCROLLVIEW
            } //VSTACK
        } //NAVIGATIONVIEW
    }
}

struct ListRoomView_Previews: PreviewProvider {
    static var previews: some View {
        ListRoomView()
    }
}
