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
    @StateObject private var vm: MainViewModel
    @State private var minimumParticipant = ""
    @State private var maximumParticipant = ""
    @State private var price = ""
    @State private var isPrivateRoom: Bool = false
    @State private var date = Date()
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State var isPresented = false
    @State var location = Location(name: "", address: "", region: "", isChecked: false)
    @State var region = ""
    @State var age = [""]
    @State var sex = "Both"
    @State var levelOfPlay = "Recreational"
    @State var sportName = ""
    @State var roomCode = ""
    @State private var isFinish: Bool = false
    @State var roomDescription = ""
    @State var name = ""
    
    @Environment(\.presentationMode) var presentationMode

    @FocusState private var inputIsFocused: Bool
    
    init(vm: MainViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
//    let userID = UserDefaults.standard.object(forKey: "userID") as? String
    
    // Generating Random String
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func checkCode() -> String {
        var code: String
        repeat {
            code = randomString(length: 6)
        } while vm.rooms.contains( where: {$0.roomCode == roomCode} )
        return code
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Section{
                    TextFieldView(textLabel: "Room's Name", isText: true, text: $name, inputIsFocused: $inputIsFocused)
                    
                    SheetButtonView(showModalButton: true, type: "sport", textLabel: $sportName)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    
//                    SheetButtonView(showModalButton: true, type: "region", textLabel: $region)
                    
                    LocationButtonView(showIcon: true, iconName: "mappin", textLabel: $location.name, location: $location, region: $region)
                    
//                    if(region != "") {
//
//                    }
                    
                    HStack {
                        TextFieldView(textLabel: "Minimum Participant", text: $minimumParticipant, inputIsFocused: $inputIsFocused)
                        TextFieldView(textLabel: "Maximum Participant", text: $maximumParticipant, inputIsFocused: $inputIsFocused)
                    }
                    
                    TextFieldView(textLabel: "Price", text: $price, inputIsFocused: $inputIsFocused)
                    
                    Toggle("Private Room", isOn: $isPrivateRoom)
                        .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 0))
                        .tint(.mint)
                    
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 0))
                        .accentColor(.mint)
                    
                    DatePicker("Starts", selection: $startTime, displayedComponents: .hourAndMinute)
                        .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 0))
                        .accentColor(.mint)
                        .onChange(of: startTime, perform: { value in
                            let dateComponents = date.get(.day, .month, .year)
                            let timeComponents = value.get(.hour, .minute)
                            if let day = dateComponents.day, let month = dateComponents.month, let year = dateComponents.year, let hour = timeComponents.hour, let minute = timeComponents.minute {
                                startTime = Calendar.current.date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute)) ?? Date()
                            }
                        })
                    
                    DatePicker("Ends", selection: $endTime, displayedComponents: .hourAndMinute)
                        .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 0))
                        .accentColor(.mint)
                        .onChange(of: endTime, perform: { value in
                            let dateComponents = date.get(.day, .month, .year)
                            let timeComponents = value.get(.hour, .minute)
                            if let day = dateComponents.day, let month = dateComponents.month, let year = dateComponents.year, let hour = timeComponents.hour, let minute = timeComponents.minute {
                                endTime = Calendar.current.date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute)) ?? Date()
                            }
                        })
                }
                
                Section(header:
                    Text("Preferences")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.primary)
                        .padding(.top, 10)
                ) {
                    HStack {
                        Text("Sex")
                            .padding(.trailing, 30)
    //                    Spacer()
                        ForEach(sexes, id: \.self){ item in
                            RadioButtonField(
                                id: item.name,
                                label: item.name,
                                color: .primary,
                                bgColor: .mint,
                                isMarked: $sex.wrappedValue == item.name ? true : false,
                                callback: { selected in
                                    self.sex = selected
                                    print("Selected Gender is: \(selected)")
                                }
                            )
                        }
                    }.padding(.vertical, 5)
                    
                    HStack {
                        Text("Competitive Level")
    //                        .padding(.trailing, 30)
                        ForEach(level, id: \.self){ item in
                            RadioButtonField(
                                id: item.name,
                                label: item.name,
                                color: .primary,
                                bgColor: .mint,
                                isMarked: $levelOfPlay.wrappedValue == item.name ? true : false,
                                callback: { selected in
                                    self.levelOfPlay = selected
                                    print("Selected Level of Play is: \(selected)")
                                }
                            )
                        }
                    }.padding(.vertical, 5)
                    
                    ChecklistSheetButtonView(showModalButton: true, type: "age", textLabel: $age)
                }
                
                Section(header:
                    Text("Room Description")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.primary)
                        .padding(.top, 10)
                ) {
                    TextFieldView(isTextEditor: true, text: $roomDescription, inputIsFocused: $inputIsFocused)
                }
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
            .padding(.horizontal)
            .navigationTitle("Create Room")
            .navigationBarTitle("Create Room", displayMode: .inline)
            .navigationBarItems(trailing: Button("Create") {
                if isPrivateRoom {
                    roomCode = checkCode()
                }
                vm.createRoom(host: vm.userID, sport: sportName, location: location.name, address: location.address, region: region, minimumParticipant: Int(minimumParticipant) ?? 0, maximumParticipant: Int(maximumParticipant) ?? 0, price: Decimal(Int(price) ?? 0), isPrivateRoom: isPrivateRoom, startTime: startTime, endTime: endTime, sex: sex, age: age, levelOfPlay: levelOfPlay, participant: [vm.userID], roomCode: roomCode, isFinish: isFinish, description: roomDescription, name: name)
                presentationMode.wrappedValue.dismiss()
            }
                .disabled(name == "" || sportName == "" || region == "" || minimumParticipant == "" || maximumParticipant == "" || startTime < Date() || endTime <= startTime)
            )
        }
    }
}

struct CreateRoomView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoomView(vm: MainViewModel(container: CKContainer.default()))
            .previewDevice("iPhone 13")
    }
}
