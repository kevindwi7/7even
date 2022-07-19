//
//  DetailRoomView.swift
//  7even
//
//  Created by Inez Amanda on 27/06/22.
//

import SwiftUI
import CoreLocation
import MapKit
import Popovers

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
    @StateObject var mapData = MapViewModel()
    @StateObject var delayMonitor = DelayMonitor()
    @Binding var room: RoomViewModel
    
    @State var isFilled: Bool = false
    @State var isPresented: Bool = false
    @State var isDeleted: Bool = false
    @State var hasJoinedChannel: Bool = false
    @State var roomCodeBtnText: String = "Room Code"
//    @State var isActive = false
    @Environment(\.presentationMode) var presentationMode
    
    private let pasteboard = UIPasteboard.general
    
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
//        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(colorToShow(for: room.sport))
                                .frame(width: 80, height: 22)
                            
                            Text(room.sport)
                                .font(.caption2)
                                .bold()
                        }
                        Spacer()
                    }

                    if(room.description != "") {
                        Text(room.description)
                            .font(.callout)
                            .foregroundColor(.gray)
                    }
                   
                    HStack {
                        Image(systemName: "calendar.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 21, height: 21)
                        Text("\(dateFormatter.string(from: room.endTime)), \(timeFormatter.string(from: room.startTime))-\(timeFormatter.string(from: room.endTime))")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 5)
                    
                    HStack {
                        Image(systemName: "dollarsign.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 21, height: 21)
                        if(room.price != 0) {
                            Text("Rp. \(String(describing: Double(truncating: room.price as NSNumber) / Double(room.maximumParticipant))),- per person")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.vertical, 7.5)
                        } else {
                            Text("Free")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.vertical, 7.5)
                        }
                    }
                    
                    Group {
                        HStack {
                            Image(systemName: "location.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 21, height: 21)
                            Text(room.location)
                                .font(.headline)
                        }
                        .foregroundColor(.gray)
                        
                        Text(room.address)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 2.5, trailing: 0))
                    }

                }
                
    //            Map(coordinateRegion: $region, annotationItems: mapData.places) { location in
    //                MapMarker(coordinate: location.coordinate, tint: .mint)
    //            }
    //            .frame(width: 340, height: 190)
                
                MapView()
                    .environmentObject(mapData)
                    .frame(width: 340, height: 190)
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
                        print(mapData.region)
                        print(mapData.places)
                    }) {
                        Text("See All")
                    }
                }
                
                ScrollView(.horizontal){
                    HStack {
                        ForEach(room.participant, id: \.self) { item in
                            
                            VStack(alignment: .center) {
                                ZStack(alignment: .bottomTrailing) {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 56.8, height: 56.8)
                                        .foregroundColor(.mint)
                                    ZStack {
                                        Image(systemName: "pentagon.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(.yellow)
                                        Text("5.0")
                                            .font(.caption2)
                                    }
                                }
                                
                                ForEach(vm.surveys, id: \.id) { user in
                                    if(user.userID == item) {
                                        Text(user.name)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.horizontal)
                    }
                    
                }

    //            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                
                if(userID == room.host) {
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
                            if !(room.isPrivateRoom) {
                                Text("Delete Room")
                                    .bold()
                                    .padding(5)
                                    .frame(width: 270)
                            } else {
                                Text("Delete Room")
                                    .bold()
                                    .padding(5)
                            }
                        }
                        .tint(.red)
                        .buttonStyle(.borderedProminent)
                        .padding(5)
                        .alert("Are you sure to delete this room?", isPresented: $isPresented) {
                            Button(role: .destructive, action: {
    //                                self.hasJoined = false
                                vm.deleteRoom(room: room) { () -> Void in
                                    try? vm.deleteChannel(room: room)
                                    self.isDeleted = true
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                print("delete room")
                            }) {
                                Text("Delete")
                            }
                        }
                        
                        Image(systemName: "square.and.arrow.up")
                            .resizable().scaledToFit()
                            .foregroundColor(.mint)
                            .frame(width: 35, height: 36, alignment: .center)
                            .padding(5)
                    }
                    .padding(5)
                } else {
                    if(room.participant.contains(userID!)) {
                        HStack {
                            Button(action: {
                                self.isPresented = true
                            }) {
                                Text("Leave Room")
                                    .bold()
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 50)
                                    .frame(width: 270)
                            }
                            .tint(.red)
                            .buttonStyle(.borderedProminent)
                            .padding(5)
                            .alert("Are you sure to leave this room?", isPresented: $isPresented) {
                                Button(role: .destructive, action: {
    //                                self.hasJoined = false
                                    vm.updateRoomMember(room: room, participantID: userID!, command: "leave") { () -> Void in
                                        try? vm.removeMemberFromChannel(room: room, userID: vm.userID)
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }) {
                                    Text("Leave")
                                }
                            }
                            
                            Image(systemName: "square.and.arrow.up")
                                .resizable().scaledToFit()
                                .foregroundColor(.mint)
                                .frame(width: 35, height: 36, alignment: .center)
                                .padding(5)
                        }
                        .padding(5)
                    } else {
                        HStack {
                            Button(action: {
                                if ( room.participant.count < room.maximumParticipant ){
                                    self.isFilled = false
                                    delayMonitor.start()
                                    print("HAS UPDATED INITIAL VALUE :\(vm.hasUpdated)")
                                    vm.updateRoomMember(room: room, participantID: userID!, command: "join") {  () -> Void in
                                        try? vm.addMemberToChannel(room: room, userID: vm.userID)
                                        
//                                        self.isActive = true
                                        print("onChange HAS UPDATED VALUE: \(vm.hasUpdated)")
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
                                    .frame(width: 270)
                            }
                            .tint(.mint)
                            .buttonStyle(.borderedProminent)
                            .padding(5)
                            .disabled(isFilled)
    //                        .onReceive(vm.$hasUpdated, perform: { value in
    //                            print("onChange HAS UPDATED VALUE: \(vm.hasUpdated)")
    //                            if(value == true) {
    //                                self.hasJoinedChannel = value
    //                            }
    //                        })
                            .onReceive(delayMonitor.$failed, perform: { value in
                                print("onChange HAS UPDATED VALUE 2: \(vm.hasUpdated)")
                                if(value == true) {
                                    self.hasJoinedChannel = value
                                }
                            })
                            .popover(
                                present: $hasJoinedChannel,
                                attributes: {
                                    $0.position = .absolute(
                                                originAnchor: .top,
                                                popoverAnchor: .bottom
                                    )
                                    $0.sourceFrameInset.top = -16
                                }
                            ) {
                                Text("New Channel")
                                    .frame(maxWidth: 250)
                                            .padding()
                                            .background(.regularMaterial)
                                            .border(.blue)
                            }
                            
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.mint)
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
                if (!self.isDeleted) {
                    vm.fetchDetailRoom(room: self.room)
                }
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if(room.host == userID) {
                        Button(action: {
                            vm.finishRoom(room: room) { () -> Void in
                                try? vm.hideChannel(room: room)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }){
                            Text("Finish")
                        }
                    }
                }
            }
            .navigationTitle(room.name)
        .navigationBarTitleDisplayMode(.large)
        }
        
//        if(self.isActive == true) {
////            JoinedRoomNotificationView()
//            NavigationLink(destination: JoinedRoomNotificationView(), isActive: $isActive, label: {
//                EmptyView()
//            })
//        }
//    }
}

//struct DetailRoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailRoomView()
//    }
//}
