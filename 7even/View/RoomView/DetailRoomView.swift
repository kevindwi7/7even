//
//  DetailRoomView.swift
//  7even
//
//  Created by Inez Amanda on 27/06/22.
//

import SwiftUI

struct DetailRoomView: View {
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }
    
    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }
    
    let userID = UserDefaults.standard.object(forKey: "userID") as? String
    
    @StateObject var vm: MainViewModel
    @Binding var room: RoomViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    func deleteRoom(_ item: RoomViewModel) {
        if let recordId = room.id {
            vm.deleteRoom(recordId)
        }
    }
    
    func ageString(arr: [String]) -> String {
        var tempMin = 0
        var tempMax = 0
        for age in arr {
            if(age != "") {
                let ageArr = age.split(separator: "-")
                print(ageArr)
                let minAge = Int(ageArr[0])
                let maxAge = Int(ageArr[1])
                if (tempMin <= minAge ?? 0){
                    tempMin = minAge ?? 0
                }
                if ( tempMax <= maxAge ?? 0) {
                    tempMax = maxAge ?? 0
                }
            }
        }
        return ("\(tempMin)-\(tempMax)")
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(room.location)
                    .font(.title2)
                    .foregroundColor(.gray)
                Text(room.address)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2.5, trailing: 0))
                
                if(room.price != 0) {
                    Text("Rp. \(String(describing: room.price)),-")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.vertical, 7.5)
                } else {
                    Text("Free")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.vertical, 7.5)
                }

                HStack {
                    Text(dateFormatter.string(from: room.endTime))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(timeFormatter.string(from: room.startTime))-\(timeFormatter.string(from: room.endTime))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 5)
            }
            
            Rectangle()
                .fill(.mint)
                .frame(width: 295, height: 166)
                .padding(.vertical, 5)
            
            HStack {
                if(room.levelOfPlay != "" || room.levelOfPlay.isEmpty == false){
                    // IF STATEMENT TO SET COMPETITIVE LEVEL COLOR
                    HStack{
                        Circle()
                            .fill(Color(UIColor.systemGreen))
                            .frame(width: 9, height: 9)
                        
                        Text(room.levelOfPlay)
                            .font(.caption)
                    }
                    .padding(.horizontal, 10)
                }
                
                if(room.sex != "" || room.sex.isEmpty == false) {
                    HStack{
                        Circle()
                            .fill(Color(UIColor.systemGreen))
                            .frame(width: 9, height: 9)
                        
                        Text(room.sex)
                            .font(.caption)
                    }
                    .padding(.horizontal, 10)
                }
                
                if(room.age != [""] || room.age.isEmpty == false){
                    let age = ageString(arr: room.age)
                    
                    if age != "0-0" {
                        HStack{
                            Circle()
                                .fill(Color(UIColor.systemGreen))
                                .frame(width: 9, height: 9)
                            
                            Text(age)
                                .font(.caption)
                        }
                        .padding(.horizontal, 10)
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
            
            HStack {
                Text("\(room.participant.count)/\(room.maximumParticipant) Participants")
                Spacer()
                Button (action: {
                    print("Tap Participant Button")
                }) {
                    Text("See All")
                }
            }
            
            HStack {
                HStack {
                    Circle()
                        .frame(width: 56.8, height: 56.8)
                    VStack {
                        Text("Dwi")
                        Text("Rate Rate")
                    }
                }
                Spacer()
                HStack {
                    Circle()
                        .frame(width: 56.8, height: 56.8)
                    VStack {
                        Text("Dwi")
                        Text("Rate Rate")
                    }
                }
            }
            
            HStack {
                HStack {
                    Circle()
                        .frame(width: 56.8, height: 56.8)
                    VStack {
                        Text("Dwi")
                        Text("Rate Rate")
                    }
                }
                Spacer()
                HStack {
                    Circle()
                        .frame(width: 56.8, height: 56.8)
                    VStack {
                        Text("Dwi")
                        Text("Rate Rate")
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            
            if(userID == room.host) {
                HStack {
                    Button(action: {
                        
                    }) {
                        Text("Room Code")
                            .bold()
                            .padding(5)
                    }
                    .tint(.mint)
                    .buttonStyle(.borderedProminent)
                    .padding(5)
                    
                    Button(action: {
                        deleteRoom(room)
                    }) {
                        Text("Delete Room")
                            .bold()
                            .padding(5)
                    }
                    .tint(.red)
                    .buttonStyle(.borderedProminent)
                    .padding(5)
                    
                    Image(systemName: "square.and.arrow.up")
                        .frame(width: 35, height: 36, alignment: .center)
                        .padding(5)
                }
                .padding(5)
            } else {
                if(room.participant.contains(userID!)) {
                    HStack {
                        Button(action: {
//                            room.participant.removeAll(where: $0 == userID)
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Leave Room")
                                .bold()
                                .padding(.vertical, 5)
                                .padding(.horizontal, 50)
                        }
                        .tint(.red)
                        .buttonStyle(.borderedProminent)
                        .padding(5)
                        
                        Image(systemName: "square.and.arrow.up")
                            .frame(width: 35, height: 36, alignment: .center)
                            .padding(5)
                    }
                    .padding(5)
                } else {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Join Room")
                                .bold()
                                .padding(.vertical, 5)
                                .padding(.horizontal, 50)
                        }
                        .tint(.mint)
                        .buttonStyle(.borderedProminent)
                        .padding(5)
                        
                        Image(systemName: "square.and.arrow.up")
                            .frame(width: 35, height: 36, alignment: .center)
                            .padding(5)
                    }
                    .padding(5)
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle(room.sport)
        .navigationBarTitleDisplayMode(.large)
    }
}

//struct DetailRoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailRoomView()
//    }
//}
