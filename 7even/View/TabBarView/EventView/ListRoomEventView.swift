//
//  ListRoomEventView.swift
//  7even
//
//  Created by Kevin  Dwi on 11/07/22.
//

import SwiftUI
import CloudKit

struct ListRoomEventView: View {
    
    @StateObject var vm: MainViewModel
  
    @State var searchText = ""
    @State var userID = UserDefaults.standard.object(forKey: "userID") as? String
    @State var isContentView = false

    let defaults = UserDefaults.standard
   
    private let roomAdaptiveColumns = [
        GridItem(.adaptive(minimum: 250)),
        GridItem(.adaptive(minimum: 250))
    ]
    
    private let myRoomCategory = [
        "On Going Events",
        "Upcoming Events",
        "Completed Events"
    ]
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    ForEach(myRoomCategory, id: \.self){ myRoom in
                        VStack(alignment: .leading) {
                            Text(myRoom)
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            
                            if(myRoom == "On Going Events" ){
                                if(!defaults.bool(forKey: "login")){
                    //                ScrollView(.vertical){
                                        Spacer()
                                        VStack(alignment: .leading){
                                            LazyVStack{
                                                
                                                
                                                Text("Sign up to manage your profile")
                                                NavigationLink(destination: LoginView(toMainPage: $isContentView, vm: vm),isActive: $isContentView){
                                                    EmptyView()
                                                    //
                                                }
                                                Button("Here"){
                                                    isContentView = true
                                                }
                                            }.padding(.vertical, 25)
                                            Spacer()
                                        }.onAppear{
                                            vm.fetchSurvey()
                                        }
                                        
                                        Spacer()
                    //                }
                                }else{
                                   
                                        LazyVGrid(columns: roomAdaptiveColumns, alignment: .center, spacing: 5){
                                            ForEach($vm.rooms, id: \.id){ $item13 in
                                              
                                                    OnGoingEventView(vm: self.vm, room: $item13)
                                                }
    //
                                        }.padding(.horizontal)
                                    
                                    
//
                                }
                            }else if (myRoom == "Upcoming Events"){
                                LazyVGrid(columns: roomAdaptiveColumns, alignment: .center, spacing: 5){
                                    ForEach($vm.rooms, id: \.id){ $item2 in
                                       
                                            UpcomingEventsCardView(vm: self.vm, room: $item2)
                                        
                                    
                                    }
                                }.padding(.horizontal)
//
                            }else if (myRoom == "Completed Events"){
                                LazyVGrid(columns: roomAdaptiveColumns, alignment: .center, spacing: 5){
                                    ForEach($vm.rooms, id: \.id){ $item3 in
                                        CompletedEventView(vm: self.vm, room: $item3)
                                    }
//
                                }.padding(.horizontal)
                              
                            }
                        }
                    }
                }
            }.onAppear {
                userID = UserDefaults.standard.object(forKey: "userID") as? String
                vm.fetchRoom()
            }
            .onReceive(vm.objectWillChange) { _ in
                if(defaults.bool(forKey: "login")){
                    vm.fetchSurvey()
                    if(vm.surveys.contains(where: { $0.userID == userID })) {
                        vm.fetchRoom()
                    }
                }
            }.navigationTitle("Events")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always),prompt: "Search")
           
        }
    }}

//struct ListRoomEventView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListRoomEventView(vm: MainViewModel(container: CKContainer.default()))
//    }
//}

