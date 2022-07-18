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
    
    @StateObject var vm: MainViewModel
    @State var selectedRoom: String?
    
    @State var isPresented = false
    @State var roomCode = ""
    @State var isActive = false
    @State var selectedSport: [String]
    
    let defaults = UserDefaults.standard
//    @State var userID = UserDefaults.standard.object(forKey: "userID") as? String
    @State var isListRoomView = false
    //    init(vm: MainViewModel) {
    //        _vm = StateObject(wrappedValue: vm)
    //    }
    
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
                
                HStack{
                    
                    ScrollView(.horizontal){
                        LazyVStack(alignment: .leading){
                            HStack {
                                ForEach(sports, id: \.self) { sport in
                                    Button(action: {
                                        for index in selectedSport {
                                            if (index == sport.name){
                                                // MARK BUTTON AS CHECKED
                                                if let matchingIndex = sports.firstIndex(where: { $0.id == sport.id }) {
                                                    sports[matchingIndex].isCheck = true
                                                }
                                            }
                                        }
                                        
                                        if let matchingIndex = sports.firstIndex(where: { $0.id == sport.id }) {
                                            sports[matchingIndex].isCheck.toggle()
                                            
                                            if(sports[matchingIndex].isCheck == true) {
                                                self.selectedSport.append(sport.name)
                                            } else {
                                                let match = self.selectedSport.firstIndex(where: { $0 == sport.name})
                                                self.selectedSport.remove(at: match ?? 0)
                                            }
                                        }
                                        print(selectedSport)
                                    }){
                                        if(sport.isCheck == true){
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color(UIColor.systemYellow))
                                                    .frame(width: 80, height: 80)
                                                VStack{
                                                    Image(sport.image)
                                                        .renderingMode(.template)
                                                        .foregroundColor(.black)
                                                    Text(sport.name)
                                                        .font(.caption2)
                                                        .foregroundColor(Color.black)
                                                }
                                                
                                            }
                                        }else{
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color(UIColor.systemGray6))
                                                    .frame(width: 80, height: 80)
                                                VStack{
                                                    Image(sport.image)
                                                        .renderingMode(.template)
                                                        .foregroundColor(.primary)
                                                    Text(sport.name)
                                                        .font(.caption2)
                                                        .foregroundColor(Color.primary)
                                                }
                                                
                                            }
                                        }
                                        
                                    }
                                    
                                }
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        
                    }
                    Group {
                        VStack{
                            Text("See All")
                                .font(.caption)
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                        }
                        .frame(width: 40)
                        .onTapGesture {
                            print("Open Filter Sheet")
                        }
                    }.padding(.horizontal)
                    
                }
                
                
                
                ScrollView(.vertical) {
                    
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
                                        NavigationLink(destination: LoginView(toMainPage: $isListRoomView, vm: vm),isActive: $isListRoomView){
                                            EmptyView()
                                            //
                                        }
                                        Button("Here"){
                                            isListRoomView = true
                                        }
                                    }.padding(.vertical, 25)
                                } else {
                                    LazyVGrid(columns: roomAdaptiveColumns, alignment: .center, spacing: 5) {
                                        if(vm.rooms.isEmpty) {
                                            Button(action: {
                                                self.isActive = true
                                            }) {
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .strokeBorder(.mint)
                                                    //                        .shadow(radius: 1.5)
                                                        .frame(width: 170, height: 127)
                                                    
                                                    
                                                    
                                                    VStack{
                                                        Image(systemName: "plus")
                                                            .font(.largeTitle)
                                                            .foregroundColor(.mint)
                                                        
                                                        Text("Create your").foregroundColor(.mint)
                                                        
                                                        Text("own rooms").foregroundColor(.mint)
                                                    }
                                                } //ZSTACK
                                            } //BUTTON
                                            .background(
                                                NavigationLink(destination: CreateRoomView(vm: MainViewModel(container: CKContainer.default())), isActive: $isActive, label: {
                                                    EmptyView()
                                                })
                                            )
                                            .padding(.vertical, 5)
                                        } else {
                                            ForEach($vm.rooms, id: \.id) { $index in
                                                ForEach($vm.surveys, id: \.id) { $item in
                                                    if( item.userID == vm.userID && item.favoriteSport.contains(index.sport)) {
                                                        ListRoomCardView(vm: self.vm, room: $index)
                                                    }
                                                }
                                                
                                                if ( index == vm.rooms.last ) {
                                                    ListRoomCardView(vm: self.vm, room: $index, isAddRoomButton: true)
                                                }
                                            }
                                        }
                                        
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal)
                                }
                            } else {
                                LazyVGrid(columns: roomAdaptiveColumns, alignment: .center, spacing: 5) {
                                    ForEach($vm.rooms, id: \.id) { $index in
                                        //                                            if( index.participant.contains(userID ?? "") == false){
                                        ListRoomCardView(vm: self.vm, room: $index)
                                        //                                            }
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                            }
                            
                        } //VSTACK
                    }
                } // SCROLLVIEW
            } //VSTACK
            .navigationBarBackButtonHidden(true)
            .onAppear {
                vm.fetchUserID()
                vm.fetchRoom()
            }
            .onReceive(vm.objectWillChange) { _ in
                if(defaults.bool(forKey: "login")){
                    vm.fetchSurvey()
                    //                    print(userID)
                    //                    print(vm.surveys.contains(where: { $0.userID == userID }))
                    if(vm.surveys.contains(where: { $0.userID == vm.userID })) {
                        vm.fetchRoom()
                    }
                }
            }
        } //NAVIGATIONVIEW
    }
}

struct ListRoomView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
