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
    
//    let userID = UserDefaults.standard.object(forKey: "userID") as? String
    
    @StateObject var vm: MainViewModel
    @Binding var room: RoomViewModel
    
    @State var isFilled: Bool = false
    @State var isPresented: Bool = false
    @State var roomCodeBtnText: String = "Room Code"
    @Environment(\.presentationMode) var presentationMode
    
    private let pasteboard = UIPasteboard.general
    
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
    
    func copyToClipboard(){
        pasteboard.string = self.room.roomCode
        self.roomCodeBtnText = "Copied!"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.roomCodeBtnText = "Room Code"
        }
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
                    HStack{
                        Circle()
                            .fill( room.levelOfPlay == "Recreational" ? Color(UIColor.systemGreen) : Color(UIColor.systemOrange) )
                            .frame(width: 9, height: 9)
                        
                        Text(room.levelOfPlay)
                            .font(.caption)
                    }
                    .padding(.horizontal, 10)
                }
                
                if(room.sex != "" || room.sex.isEmpty == false) {
                    HStack{
                        if(room.sex == "Female") {
                            Circle()
                                .fill(Color(UIColor.systemPink))
                                .frame(width: 9, height: 9)
                        } else if(room.sex == "Male") {
                            Circle()
                                .fill(Color(UIColor.systemBlue))
                                .frame(width: 9, height: 9)
                        } else {
                            Circle()
                                .fill(Color(UIColor.systemTeal))
                                .frame(width: 9, height: 9)
                        }

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
                                .fill(Color(UIColor.systemYellow))
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
                HStack(alignment: .center) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 56.8, height: 56.8)
//                        .padding()
                        .foregroundColor(.mint)
                    VStack(alignment: .leading) {
                        Text("Dwi")
                        HStack{
                            Image("star").resizable().scaledToFit()
                            Image("star").resizable().scaledToFit()
                            Image("star").resizable().scaledToFit()
                            Image("star").resizable().scaledToFit()
                            Image("star").resizable().scaledToFit()
                        }
                    }
                }
                .padding(.horizontal)
                Spacer()
                HStack(alignment: .center) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 56.8, height: 56.8)
//                        .padding()
                        .foregroundColor(.mint)
                    VStack(alignment: .leading) {
                        Text("Dwi")
                        HStack{
                            Image("star").resizable().scaledToFit()
                            Image("star").resizable().scaledToFit()
                            Image("star").resizable().scaledToFit()
                            Image("star").resizable().scaledToFit()
                            Image("star").resizable().scaledToFit()
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            HStack {
                HStack(alignment: .center) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 56.8, height: 56.8)
                        .foregroundColor(.mint)
                    VStack(alignment: .leading) {
                        Text("Dwi")
                        HStack{
                            Image("star").resizable().scaledToFit()
                            Image("star").resizable().scaledToFit()
                            Image("star").resizable().scaledToFit()
                            Image("star").resizable().scaledToFit()
                            Image("star").resizable().scaledToFit()
                        }
                    }
                }
                .padding(.horizontal)
                Spacer()
                HStack(alignment: .center) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 56.8, height: 56.8)
                        .foregroundColor(.mint)
                    VStack(alignment: .leading) {
                        Text("Dwi")
                        HStack{
                            Image("star").resizable().scaledToFit()
                            Image("star").resizable().scaledToFit()
                            Image("star").resizable().scaledToFit()
                            Image("star").resizable().scaledToFit()
                            Image("star").resizable().scaledToFit()
                        }
                    }
                }
                .padding(.horizontal)
            }
//            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            
            if(vm.userID == room.host) {
                HStack {
                    if(room.isPrivateRoom) {
                        Button(action: {
                            copyToClipboard()
                        }) {
                            Text(roomCodeBtnText)
                                .bold()
                                .padding(5)
                        }
                        .tint(.mint)
                        .buttonStyle(.borderedProminent)
                        .padding(5)
                    }
                    
                    Button(action: {
                        self.isPresented = true
                    }) {
                        Text("Delete Room")
                            .bold()
                            .padding(5)
                    }
                    .tint(.red)
                    .buttonStyle(.borderedProminent)
                    .padding(5)
                    .alert("Are you sure to delete this room?", isPresented: $isPresented) {
                        Button(role: .destructive, action: {
//                                self.hasJoined = false
                            deleteRoom(room)
                            try? vm.deleteChannel(room: room)
                            self.presentationMode.wrappedValue.dismiss()
                            print("delete room")
                        }) {
                            Text("Delete")
                        }
                    }
                    
                    Image(systemName: "square.and.arrow.up")
                        .resizable().scaledToFit()
                        .frame(width: 35, height: 36, alignment: .center)
                        .padding(5)
                }
                .padding(5)
            } else {
                if(room.participant.contains(vm.userID)) {
                    HStack {
                        Button(action: {
                            self.isPresented = true
                        }) {
                            Text("Leave Room")
                                .bold()
                                .padding(.vertical, 5)
                                .padding(.horizontal, 50)
                        }
                        .tint(.red)
                        .buttonStyle(.borderedProminent)
                        .padding(5)
                        .alert("Are you sure to leave this room?", isPresented: $isPresented) {
                            Button(role: .destructive, action: {
//                                self.hasJoined = false
                                vm.updateRoom(room: room, participantID: vm.userID, command: "leave") { () -> Void in
                                    try? vm.removeMemberFromChannel(room: room, userID: vm.userID)
                                }
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Leave")
                            }
                        }
                        
                        Image(systemName: "square.and.arrow.up")
                            .resizable().scaledToFit()
                            .frame(width: 35, height: 36, alignment: .center)
                            .padding(5)
                    }
                    .padding(5)
                } else {
                    HStack {
                        Button(action: {
                            if ( room.participant.count < room.maximumParticipant ){
                                self.isFilled = false
                                vm.updateRoom(room: room, participantID: vm.userID, command: "join") {  () -> Void in
                                    try? vm.addMemberToChannel(room: room, userID: vm.userID)
                                }
                            } else {
                                self.isFilled = true
                            }
//                            self.presentationMode.wrappedValue.dismiss()
                            print(room.participant)
//                            self.hasJoined = true
                        }) {
                            Text("Join Room")
                                .bold()
                                .padding(.vertical, 5)
                                .padding(.horizontal, 50)
                        }
                        .tint(.mint)
                        .buttonStyle(.borderedProminent)
                        .padding(5)
                        .disabled(isFilled)
                        
                        Image(systemName: "square.and.arrow.up")
                            .frame(width: 35, height: 36, alignment: .center)
                            .padding(5)
                    }
                    .padding(5)
                }
            }
        }
        .onAppear {
            vm.fetchDetailRoom(room: self.room )
        }
        .onReceive(vm.objectWillChange) { _ in
            vm.fetchDetailRoom(room: self.room)
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
