//
//  CreateRoomView.swift
//  7even
//
//  Created by Inez Amanda on 21/06/22.
//

import SwiftUI
import CloudKit

struct CreateRoomView: View {
    
    var isEnabled = false
    @StateObject private var roomViewModel: RoomViewModel
    @State private var minimumParticipant = ""
    @State private var maximumParticipant = ""
    @State private var price = ""
    @State private var isPrivateRoom: Bool = false
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State var isPresented = false
    @State var location = Location(name: "", address: "", region: "")
    @State var region = ""
    @State var age = [""]
    @State var sex = ""
    @State var levelOfPlay = ""
    @State var sportName = ""

    @FocusState private var inputIsFocused: Bool
    
    init(roomViewModel: RoomViewModel) {
        _roomViewModel = StateObject(wrappedValue: roomViewModel)
    }
    
    var body: some View {
        
//        NavigationView {
            
            GeometryReader { geometry in
                
                List {
                    Section{
                        SheetButtonView(showModalButton: true, type: "sport", textLabel: $sportName)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                        
                        SheetButtonView(showModalButton: true, type: "region", textLabel: $region)
                        
                        if(region != "") {
                            LocationButtonView(showIcon: true, iconName: "mappin", textLabel: $location.name, location: $location, region: $region)
                        }
                        
                        HStack {
                            TextFieldView(textLabel: "Minimum Participant", inputNumber: $minimumParticipant, inputIsFocused: $inputIsFocused)
                            TextFieldView(textLabel: "Maximum Participant", inputNumber: $maximumParticipant, inputIsFocused: $inputIsFocused)
                        }
                        
                        TextFieldView(textLabel: "Price", inputNumber: $price, inputIsFocused: $inputIsFocused)
                        
                        Toggle("Private Room", isOn: $isPrivateRoom)
                            .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 0))
                            .tint(.mint)
                        
                        DatePicker("Starts", selection: $startTime)
                            .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 0))
                            .accentColor(.mint)
                        
                        DatePicker("Ends", selection: $endTime)
                            .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 0))
                            .accentColor(.mint)
                    }
                    .listRowSeparator(.hidden)
                    
                    Section(header: Text("Preferences")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.primary)) {
                            
                            SheetButtonView(showModalButton: true, type: "sex", textLabel: $sex)
                            
                            SheetButtonView(showModalButton: true, type: "levelOfPlay", textLabel: $levelOfPlay)
                            
                            ChecklistSheetButtonView(showModalButton: true, type: "age", textLabel: $age)
                            
                            
                    }
                    .listRowSeparator(.hidden)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            roomViewModel.createRoom(host: "SDFSF", sport: sportName, location: location.name, region: region, minimumParticipant: Int(minimumParticipant) ?? 0, maximumParticipant: Int(maximumParticipant) ?? 0, price: Decimal(Int(price) ?? 0), isPrivateRoom: isPrivateRoom, startTime: startTime, endTime: endTime, sex: sex, age: age, levelOfPlay: levelOfPlay)
                            
                            self.sportName = ""
                            self.region = ""
                            self.location = Location(name: "", address: "", region: "")
                            self.minimumParticipant = ""
                            self.maximumParticipant = ""
                            self.price = ""
                            if(self.isPrivateRoom == true) {
                                self.isPrivateRoom.toggle()
                            }
                            self.startTime = Date()
                            self.endTime = Date()
                            self.sex = ""
                            self.levelOfPlay = ""
                            self.age = [""]
                        }) {
                            Text("Create")
                                .padding(5)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.mint)
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                                    
                        Button("Done") {
                            inputIsFocused = false
                        }
                        .accessibilityAddTraits(.isKeyboardKey)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Create Room")
                .navigationBarTitleDisplayMode(.inline)
            }
//        }
    }
}

struct CreateRoomView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoomView(roomViewModel: RoomViewModel(container: CKContainer.default()))
            .previewDevice("iPhone 13")
    }
}
