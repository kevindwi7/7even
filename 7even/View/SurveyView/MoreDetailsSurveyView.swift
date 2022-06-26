//
//  MoreDetailsSurveyView.swift
//  7even
//
//  Created by Kevin  Dwi on 24/06/22.
//

import SwiftUI
import CloudKit

struct MoreDetailsSurveyView: View {
    @StateObject private var mainViewModel: MainViewModel
    @State private var isShowingPhotoPicker = false
    @State private var avatarImage = UIImage(named: "apple")!
    @State var action: Int? = 0
    @State var profileName: String = ""
    @State var birthDate = Date()
    @State var gender = "Male"
    @State var sportWith: String = ""
    
    @State var favoriteSports  = [""]
    //
    
    @FocusState private var inputIsFocused: Bool
    
    var sex = ["Male", "Female"]
    var sportsWith = ["Strangers","Partners","Both"]
    
    init(mainViewModel: MainViewModel) {
        _mainViewModel = StateObject(wrappedValue: mainViewModel)
    }
    
    public var body: some View {
        List{
            Section{
                Text("Almost there! Just a few more things for us to know you better.")
                    .multilineTextAlignment(.center)
                    .padding(.vertical)
                HStack{
                    Spacer()
                    Text("Add your best photo of yourself")  .multilineTextAlignment(.center)
                    Spacer()
                }
                
                HStack{
                    Spacer()
                    Image(uiImage: avatarImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120, alignment: .center)
                        .clipShape(Circle())
                        .padding()
                        .onTapGesture {
                            isShowingPhotoPicker = true
                        }
                    Spacer()
                }
                
                VStack{
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
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
                    }.listRowSeparator(.hidden)
                    
                }
                
                
                SurveySheetButtonView(showModalButton: true, type: "favoriteSport", textLabel: $favoriteSports)
                
                VStack{
                    Section(header: Text("Birthdate")
                        .font(.title3)
                            
                        .bold()
                        .foregroundColor(.primary)) {
                            DatePicker("", selection: $birthDate, displayedComponents: .date)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 2))
                                .padding()
                                .labelsHidden()
                                .frame(width: 350, height: 50, alignment: .center)
                            
                        }.listRowSeparator(.hidden)
                    
                }.listRowSeparator(.hidden)
                
                
                
                
            }
            .listRowSeparator(.hidden)
            
            VStack{
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
                    }.listRowSeparator(.hidden)
            }.listRowSeparator(.hidden)
            
            VStack{
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
                        
                        
                    }.listRowSeparator(.hidden)
            }
            
            
            VStack{
                NavigationLink(destination: TabBarView(), tag: 1, selection: $action){
                    EmptyView()
                    
                    
                }
                Button(action: {
                    mainViewModel.createSurvey(name: profileName, birthDate: birthDate , sex: gender, sportWith: sportWith, favoriteSport: favoriteSports )
                    
                    self.action = 1
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
            .padding()
            .navigationTitle("Tell us more about you")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isShowingPhotoPicker, content: {
                SurveyPhotoPicker(avatarImage: $avatarImage)
            })
        }
        .listStyle(.plain)
        
        
    }
}

struct MoreDetailsSurveyView_Previews: PreviewProvider {
    static var previews: some View {
        MoreDetailsSurveyView(mainViewModel: MainViewModel(container: CKContainer.default()))
    }
}

