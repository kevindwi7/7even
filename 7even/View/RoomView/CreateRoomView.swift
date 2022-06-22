//
//  CreateRoomView.swift
//  7even
//
//  Created by Inez Amanda on 21/06/22.
//

import SwiftUI
import CloudKit

struct CreateRoomView: View {
    @StateObject private var roomViewModel: RoomViewModel
    
    @State private var minimumParticipant = ""
    @State private var maximumParticipant = ""
    @State private var price = ""
    @State private var isPrivateRoom: Bool = false
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State var isPresented = false
    
    var sportList = [
        "Tennis",
        "Badminton",
        "Football",
        "Yoga",
        "Basketball",
        "Volleyball"
    ]
    
    init(roomViewModel: RoomViewModel) {
        _roomViewModel = StateObject(wrappedValue: roomViewModel)
    }
    
    var body: some View {
        
        NavigationView {
            
            GeometryReader { geometry in
                
                List {
                    Section{
                        ButtonModalView(textLabel: "Type of Sport", showModalButton: true, type: PREFERENCETYPE.sport.rawValue)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                        
                        ButtonModalView(textLabel: "Choose Location", showIcon: true, iconName: "mappin")
                        
                        HStack {
                            TextFieldView(textLabel: "Minimum Participant", inputNumber: $minimumParticipant)
                            TextFieldView(textLabel: "Maximum Participant", inputNumber: $maximumParticipant)
                        }
                        
                        TextFieldView(textLabel: "Price", inputNumber: $price)
                        
                        Toggle("Private Room", isOn: $isPrivateRoom)
                            .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 0))
                        
                        DatePicker("Starts", selection: $startTime)
                            .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 0))
                        
                        DatePicker("Ends", selection: $endTime)
                            .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 0))
                    }
                    .listRowSeparator(.hidden)
                    
                    Section(header: Text("Preferences")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.primary)) {
                            ButtonModalView(textLabel: "Sex", showModalButton: true, type: PREFERENCETYPE.sex.rawValue)
                            ButtonModalView(textLabel: "Level of Play", showModalButton: true, type: PREFERENCETYPE.level.rawValue)
                            ButtonModalView(textLabel: "Age", showModalButton: true, type: PREFERENCETYPE.age.rawValue)
                    }
                    .listRowSeparator(.hidden)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            roomViewModel.createRoom(sport: sportList, location: "location", minimumParticipant: Int(minimumParticipant) ?? 0, maximumParticipant: Int(maximumParticipant) ?? 0, price: Decimal(Int(price) ?? 0), isPrivateRoom: isPrivateRoom, startTime: startTime, endTime: endTime, sex: "Male Only", age: "20-25", levelOfPlay: "Recreational")
                            
                            self.minimumParticipant = ""
                            self.maximumParticipant = ""
                            self.price = ""
                            if(self.isPrivateRoom == true) {
                                self.isPrivateRoom.toggle()
                            }
                            self.startTime = Date()
                            self.endTime = Date()
                        }) {
                            Text("Create")
                                .padding(5)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .navigationTitle("Create Room")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct CreateRoomView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoomView(roomViewModel: RoomViewModel(container: CKContainer.default()))
            .previewDevice("iPhone 13")
    }
}
