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
    @State var sportRoutine: String = ""
    @State private var age: DateComponents = DateComponents()
    
    @Binding var toMainPage: Bool
    @Binding var favoriteSports: [String]
    
    @FocusState private var inputIsFocused: Bool
    
    var usersID = UserDefaults.standard.object(forKey: "userID") as! String
    
    public var body: some View {
        VStack(alignment: .leading){
            ScrollView{
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
                            .frame(height: 100, alignment: .center)
                            .padding()
                            .onTapGesture {
                                isShowingPhotoPicker = true
                            }
                        Spacer()
                    }
                    
                    Section(header:
                                HStack{
                        Text("Name")
                            .font(.system(size: 16))
                            .bold()
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    )
                    {
                        ZStack {
                            Color(.systemBackground)
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    TextField("", text: $profileName)
                                    
                                }.padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                            }.padding(5)
                        }
                        .cornerRadius(12)
                        .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
                        .fixedSize(horizontal: false, vertical: true)
                        .shadow(color: Color.black, radius: 1)
                    }
                    .padding(.horizontal,10)
                    .padding(5)
                    
                    Section(header:
                                HStack{
                        Text("BirthDate")
                            .font(.system(size: 16))
                            .bold()
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    ){
                        HStack{
                            DatePicker("", selection: $birthDate, displayedComponents: .date)
                                .onChange(of: birthDate, perform: { value in
                                    age = Calendar.current.dateComponents([.year], from: birthDate, to: Date())
                                    
                                    
                                })
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 2))
                                .padding()
                                .labelsHidden()
                                .frame(width: 350, height: 50)
                            
                            Spacer()
                        }
                        
                        
                    }
                    .padding(.horizontal,10)
                    .padding(5)
                }
                
                
                Section(header:
                            HStack{
                    Text("Sex")
                        .font(.system(size: 16))
                        .bold()
                        .foregroundColor(.primary)
                    Spacer()
                }
                ){
                    HStack {
                        ForEach(sexesSurvey, id: \.self){ item in
                            RadioButtonField(
                                id: item.name,
                                label: item.name,
                                color: .primary,
                                bgColor: .mint,
                                isMarked: $gender.wrappedValue == item.name ? true : false,
                                callback: { selected in
                                    self.gender = selected
                                    print("Selected Gender is: \(selected)")
                                }
                            )
                        }.listRowSeparator(.hidden)
                    }.padding(.vertical, 5)
                }
                .padding(.horizontal,10)
                .padding(5)
                
                Section(header:
                            HStack{
                    Text("Sport With")
                        .font(.system(size: 16))
                        .bold()
                        .foregroundColor(.primary)
                    Spacer()
                }
                ){
                    HStack {
                        ForEach(sportsWith, id: \.self){ test in
                            RadioButtonField(
                                id: test.name,
                                label: test.name,
                                color: .primary,
                                bgColor: .mint,
                                isMarked: $sportWith.wrappedValue == test.name ? true : false,
                                callback: { selected in
                                    self.sportWith = selected
                                    print("Selected Gender is: \(selected)")
                                }
                            )
                        }
                    }.padding(.vertical, 5)
                }
                
                .padding(.horizontal,10)
                .padding(5)
                
                
                Section(header:
                            HStack{
                    Text("How often do you have sport in a week?")
                        .font(.system(size: 16))
                        .bold()
                        .foregroundColor(.primary)
                    Spacer()
                }
                ){
                    ZStack {
                        Color(.systemBackground)
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                TextField("", text: $sportRoutine)
                                
                            }.padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                        }.padding(5)
                    }
                    .cornerRadius(12)
                    .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
                    .fixedSize(horizontal: false, vertical: true)
                    .shadow(color: Color.black, radius: 1)
                }
                .padding(.horizontal,10)
                .padding(5)
                
                VStack{
                    HStack{
                        Spacer()
                        Button("Create") {
                            mainViewModel.createSurvey(name: profileName, birthDate: birthDate, sex: gender, sportWith: sportWith, favoriteSport: favoriteSports, userID: usersID, age: age.year ?? 0 )
                            
                            toMainPage = false
                            
                        }
                        .disabled(profileName == "" || gender == "" ||  sportWith == ""  )
                        .padding(.horizontal, 130)
                        .padding(.vertical, 10)
                        .buttonStyle(.borderedProminent)
                        .tint(.mint)
                        //                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
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
            
        }.padding()
    }
}

//struct MoreDetailsSurveyView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoreDetailsSurveyView(mainViewModel: MainViewModel(container: CKContainer.default()), toMainPage: toMainPage)
//    }
//}

