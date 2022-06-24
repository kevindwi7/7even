//
//  MoreDetailsSurveyView.swift
//  7even
//
//  Created by Kevin  Dwi on 24/06/22.
//

import SwiftUI
import CloudKit

struct MoreDetailsSurveyView: View {
    @StateObject private var roomViewModel: RoomViewModel
    @State private var isShowingPhotoPicker = false
    @State private var avatarImage = UIImage(named: "apple")!
    
    @State var profileName: String = ""
    @State var birthDate = Date()
    @State var gender = "Male"
    @State var sportWith: String = ""
    @State var action: Int? = 0
    
    var sex = ["Male", "Female"]
    var sportsWith = ["Strangers","Partners","Both"]
    var sport = Sport(id: "", name: "", image: "")
    
    init(roomViewModel: RoomViewModel) {
        _roomViewModel = StateObject(wrappedValue: roomViewModel)
    }
    
    public var body: some View {
        ScrollView{
            
            VStack{
                Text("Almost there! Just a few more things for us to know you better.")
                    .multilineTextAlignment(.center)
                    .padding(.vertical)
                Text("Add your best photo of yourself")
                
                Image(uiImage: avatarImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .clipShape(Circle())
                    .padding()
                    .onTapGesture {
                        isShowingPhotoPicker = true
                    }
                Text("Name")
                
                
                TextField("Enter Name", text: $profileName)
                    .padding()
                    .background(Color.gray.opacity(0.2).cornerRadius(10))
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 2))
                    .padding(.vertical)
                
                DatePicker("Birthdate", selection: $birthDate, displayedComponents: .date)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 2))
                    .padding()
                
                //                    DatePickerTextField(placeholder: "Selected Date", date: self.birthDate).padding()
                //                        .background(Color.gray.opacity(0.2).cornerRadius(10))
                //                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 2))
                //                        .padding(.vertical)
                Text("Sex")
                Picker("What is yout Gender", selection: $gender){
                    ForEach(sex, id: \.self){
                        Text($0)
                    }
                    
                }
                .pickerStyle(.segmented)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 2))
                
            }.padding()
            Spacer()
            
            Text("Sport With")
            Picker("Sport with", selection: $sportWith){
                ForEach(sportsWith, id: \.self){
                    Text($0)
                }
                
            }
            .pickerStyle(.segmented)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 2))
            HStack {
                NavigationLink(destination: TabBarView(), tag: 1, selection: $action){
                    EmptyView()
                }
                Spacer()
                Button(action: {
                    roomViewModel.createSurvey(name: profileName, birthDate: birthDate , sex: gender, sportWith: sportWith, favoriteSport: sport.name )
                    self.action = 1
                    
                }) {
                    Text("Create")
                        .padding(5)
                }
                .buttonStyle(.borderedProminent)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                Spacer()
            }
        }
        
        
        
        
        .padding()
        .navigationTitle("Tell us more about you")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingPhotoPicker, content: {
            SurveyPhotoPicker(avatarImage: $avatarImage)
        })
    }
}

struct MoreDetailsSurveyView_Previews: PreviewProvider {
    static var previews: some View {
        MoreDetailsSurveyView(roomViewModel: RoomViewModel(container: CKContainer.default()))
    }
}
