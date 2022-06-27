//
//  MoreDetailsSurveyView.swift
//  7even
//
//  Created by Kevin  Dwi on 24/06/22.
//

import SwiftUI
import CloudKit

struct MoreDetailsSurveyView: View {
    @StateObject var mainViewModel: MainViewModel
    @State private var isShowingPhotoPicker = false
    @State private var avatarImage = UIImage(named: "profile")!
    @State var action: Int? = 0
    @State var profileName: String = ""
    @State var birthDate = Date()
    @State var gender = "Male"
    @State var sportWith: String = ""
    @Binding var toMainPage: Bool
    
    @Binding var favoriteSports: [String]
    //
    
    @FocusState private var inputIsFocused: Bool
    
    var sex = ["Male", "Female"]
    var sportsWith = ["Strangers","Partners","Both"]
    
    var email = UserDefaults.standard.object(forKey: "email") as! String
    
    //    init(mainViewModel: MainViewModel) {
    //        _mainViewModel = StateObject(wrappedValue: mainViewModel)
    //    }
    
    public var body: some View {
        List{
            Section{
                Text("Almost there! Just a few more things for us to know you better.")
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .padding(.vertical)
                HStack{
                    Spacer()
                    Text("Add your best photo of yourself")  .multilineTextAlignment(.center)
                        .font(.system(size: 16, weight: .bold))
                    Spacer()
                }
                
                HStack{
                    Spacer()
                    Image(uiImage: avatarImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120, alignment: .center)
                        .padding()
                        .onTapGesture {
                            isShowingPhotoPicker = true
                        }
                    Spacer()
                }
                
                Section(header:
                            Text("Name")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.primary))
                {
                    ZStack {
                        Color(.systemBackground)
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                TextField("Enter Name", text: $profileName)
                                
                            }.padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                        }.padding(5)
                    }
                    .cornerRadius(12)
                    .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
                    .fixedSize(horizontal: false, vertical: true)
                    .shadow(color: Color.black, radius: 1)
                }
                .padding(.horizontal,10)
                .listRowSeparator(.hidden)
                
                
                
                
                Section(header: Text("Birthdate")
                    .font(.title3)
                        
                    .bold()
                    .foregroundColor(.primary)) {
                        DatePicker("", selection: $birthDate, displayedComponents: .date)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 2))
                            .padding()
                            .labelsHidden()
                            .frame(width: 350, height: 50, alignment: .center)
                        
                    }
                    .padding(.horizontal,10)
                    .listRowSeparator(.hidden)
                
            }
            .listRowSeparator(.hidden)
            
            
            Section(header: Text("Sex")
                .font(.title3)
                    
                .bold()
                .foregroundColor(.primary)) {
                    
                    Picker("What is yout Gender", selection: $gender){
                        ForEach(sex, id: \.self){
                            Text($0)
                        }
                        
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 2))
                }
                .padding(.horizontal,10)
                .listRowSeparator(.hidden)
            
            
            
            Section(header: Text("Sport With")
                .font(.title3)
                .bold()
                .foregroundColor(.primary)) {
                    Picker("Sport with", selection: $sportWith){
                        ForEach(sportsWith, id: \.self){
                            Text($0)
                        }
                        
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 2))
                    
                    
                }
                .padding(.horizontal,10)
                .listRowSeparator(.hidden)
            
            
            
            VStack{
                HStack{
                    Spacer()
                    Button("Create") {
                        mainViewModel.createSurvey(name: profileName, birthDate: birthDate , sex: gender, sportWith: sportWith, favoriteSport: favoriteSports, email: email  )
                        
                        toMainPage = false
                    }
                    .frame(width: 150, height: 80)
                    .buttonStyle(.borderedProminent)
                    .tint(.mint)
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                }
                
            }
            .listRowSeparator(.hidden)
            .padding()
            .navigationTitle("Tell us more about you")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isShowingPhotoPicker, content: {
                SurveyPhotoPicker(avatarImage: $avatarImage)
            })
        }
        .listStyle(.plain)
        
        
    }
}

//struct MoreDetailsSurveyView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoreDetailsSurveyView(mainViewModel: MainViewModel(container: CKContainer.default()), toMainPage: toMainPage)
//    }
//}

