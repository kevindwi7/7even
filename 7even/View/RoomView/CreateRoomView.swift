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
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State var isPresented = false
    @State var location = Location(name: "", address: "", region: "")
    @State var region = ""
    @State var age = [""]
    @State var sex = ""
    @State var levelOfPlay = ""
    @State var sportName = ""
    
    @Environment(\.presentationMode) var presentationMode

    @FocusState private var inputIsFocused: Bool
    
    init(vm: MainViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    let userID = UserDefaults.standard.object(forKey: "userID") as? String
    
    var body: some View {
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
                    print(vm.rooms)
                    vm.createRoom(host: userID ?? "", sport: sportName, location: location.name, address: location.address, region: region, minimumParticipant: Int(minimumParticipant) ?? 0, maximumParticipant: Int(maximumParticipant) ?? 0, price: Decimal(Int(price) ?? 0), isPrivateRoom: isPrivateRoom, startTime: startTime, endTime: endTime, sex: sex, age: age, levelOfPlay: levelOfPlay, participant: [userID ?? ""])
                    self.presentationMode.wrappedValue.dismiss()
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
}

struct CreateRoomView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoomView(vm: MainViewModel(container: CKContainer.default()))
            .previewDevice("iPhone 13")
    }
}
