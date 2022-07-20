//
//  ListRoomCardView.swift
//  7even
//
//  Created by Inez Amanda on 25/06/22.
//

import SwiftUI
import CloudKit

struct ListRoomCardView: View {
    
    @StateObject var vm: MainViewModel
    @Binding var room: RoomViewModel
    var isAddRoomButton = false
    @State var isActive = false
    @State var isPresented = false
    @State var roomCode = ""
    @State var showLoginAlert = false
   
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    let userID = UserDefaults.standard.object(forKey: "userID") as? String
    
    func colorToShow(for sportType: String) -> Color {
        switch sportType {
            case "Badminton":
                return .mint
            case "Basketball":
                return .orange
            case "Football":
                return .blue
            case "Yoga":
                return .brown
            case "Cycling":
                return .pink
            case "Running":
                return .purple
            case "Tennis":
                return .indigo
            default:
                return .gray
        }
    }
    
    var body: some View {
        if(!isAddRoomButton) {
            Button(action: {
                if(UserDefaults.standard.bool(forKey: "login")) {
                    if(room.isPrivateRoom && (room.participant.contains(userID!)) == false ){
                        self.isPresented = true
                    } else {
                        self.isActive = true
                    }
                } else {
                    self.showLoginAlert = true
                }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color(UIColor.systemGray2))
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(UIColor.systemBackground)))
                        .frame(width: 170, height: 144)
                    
                    VStack() {
                        HStack{
                            VStack(alignment: .leading, spacing: 5){
                                    HStack {
                                        Text(room.name)
                                            .bold()
                                            
                                        if( room.isPrivateRoom ) {
                                            Image(systemName: "lock.fill")
                                                .resizable().scaledToFit().frame(height:18)
                                              
                                        }
                                    }
                                    
                                    Text(room.region)
                                        .font(.subheadline)
                                     
                                    
                                    Text(dateFormatter.string(from: room.endTime))
                                        .font(.footnote)
                            
                                    
                                if room.isFinish == true{
                                    Text("")
                                }else{
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(colorToShow(for: room.sport))
                                            .frame(width: 80, height: 22)
                                        
                                        Text(room.sport)
                                            .font(.caption2)
                                            .bold()
                                    }
                                }
                                        
                       
                    
                                
                            }
                            Spacer()
                        }.padding(.horizontal)
                         //HSTACK
                        HStack(alignment: .center, spacing: 20) {
                            if (room.isFinish == true){
                                Button(action: {}){
                                    Text("Review Members")
                                        .font(.system(size: 12))
                                        .bold()
                                        .padding()
                                        .overlay(
                                                       RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.mint, lineWidth: 2)
                                               )
                                }
                                    .border(Color.mint)
                                    .cornerRadius(10)
                            }else{
                                HStack {
                                    Circle()
                                        .fill( room.levelOfPlay == "Recreational" ? Color(UIColor.systemGreen) : Color(UIColor.systemOrange))
                                        .frame(width: 9, height: 9)
                                        
                                    
                                    Text(room.levelOfPlay)
                                        .font(.caption)
                                   
                                }
                                
                                ZStack {
                                    if (room.participant.count == room.maximumParticipant) {
                                        Circle()
                                            .strokeBorder( .green )
                                            .frame(width: 30, height: 30)
                                    } else if (room.participant.count >= (Int(Double(room.maximumParticipant * 2)/3))) {
                                        Circle()
                                            .strokeBorder( .mint )
                                            .frame(width: 30, height: 30)
                                    } else {
                                        Circle()
                                            .strokeBorder( .gray )
                                            .frame(width: 30, height: 30)
                                    }
                                    
                                    Text("\(room.participant.count)/\(room.maximumParticipant)")
                                        .font(.caption2)
                                        .foregroundColor(.mint)
                                }
                            }
                            

                        } //HSTACK
                    } //VSTACK
                    .foregroundColor(Color.primary)
                    
                } //ZSTACK
            } //BUTTON
            .background(
                NavigationLink(destination: DetailRoomView(vm: self.vm, room: $room), isActive: $isActive, label: {
                    EmptyView()
                })
            )
            .background(
                AlertControl(textString: self.$roomCode, show: self.$isPresented, room: $room, isActive: $isActive,
                             title: "Private Sports Room", message: "You can get your room's code from the host")
            )
            .alert("Sign In First", isPresented: $showLoginAlert, actions: {
                Button("Ok") {}
            })
            .padding(.vertical, 5)
            .onAppear {
                vm.fetchUserID()
            }
        }
        else {
            Button(action: {
                self.isActive = true
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(.mint)
//                        .shadow(radius: 1.5)
                        .frame(width: 170, height: 144)
                    
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
        }
        
    }
}

struct ListRoomCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
