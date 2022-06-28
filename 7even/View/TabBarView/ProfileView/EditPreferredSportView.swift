//
//  EditPreferredSportView.swift
//  7even
//
//  Created by Kevin  Dwi on 28/06/22.
//

import SwiftUI
import CloudKit

struct EditPreferredSportView: View {
    @Binding var toMainPage: Bool
    @State var isCheck = false
    @State var isContentView = true
    @State var selectedSport: [String]
    @State var sportName = ""
    @State var searchText = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack{
                Text("Select Maximum 2 Sports")
                    .fontWeight(.bold)
                Spacer()
                
            }.padding()
            Spacer()
            
            VStack(spacing:15){
                //                (searchText == "" ? sports : sports.filter{$0.name.lowercased().contains(searchText.lowercased())}, id: \.self)
                List(searchText == "" ? sports : sports.filter{$0.name.lowercased().contains(searchText.lowercased())}, id: \.self){ sport in
                    Button(action: {
                        for index in selectedSport {
                            if (index == sport.name){
                                // MARK BUTTON AS CHECKED
                                if let matchingIndex = sports.firstIndex(where: { $0.id == sport.id }) {
                                    sports[matchingIndex].isCheck = true
                                }
                            }
                        }
                        
                        if let matchingIndex = sports.firstIndex(where: { $0.id == sport.id }) {
                            sports[matchingIndex].isCheck.toggle()
                            
                            if(sports[matchingIndex].isCheck == true) {
                                self.selectedSport.append(sport.name)
                            } else {
                                let match = self.selectedSport.firstIndex(where: { $0 == sport.name})
                                self.selectedSport.remove(at: match ?? 0)
                            }
                        }
                        print(selectedSport)
                    }){
                        
                        if(sport.isCheck == true){
                            ZStack{
                                RoundedRectangle(cornerRadius: 10).stroke(.mint, lineWidth: 2)
                                    .shadow(radius: 5)
                                VStack{
                                    HStack{
                                        Text(sport.name)
                                            .foregroundColor(.black)
                                        Spacer()
                                        Image(sport.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 32)
                                        
                                    }
                                    
                                }.padding()
                            }
                            .foregroundColor(.mint)
                            .padding(.horizontal)
                            .listRowSeparator(.hidden)
                        }else{
                            ZStack{
                                RoundedRectangle(cornerRadius: 10).fill(.white)
                                    .shadow(radius: 5)
                                VStack{
                                    HStack{
                                        Text(sport.name)
                                            .foregroundColor(.black)
                                        Spacer()
                                        Image(sport.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 32)
                                    }
                                    
                                }.padding()
                            }
                            .padding(.horizontal)
                            .listRowSeparator(.hidden)
                            
                            
                        }
                        
                    }
                    
                    .listRowSeparator(.hidden)
                    
                    .listRowSeparator(.hidden)
                    .listStyle(.plain)
                    
                    Spacer()
                }.listStyle(.plain)
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always),prompt: "Search")
                    .padding(.top,10)
                
                
                HStack{
                    Spacer()
                    Button("Edit") {
//                        mainViewModel.createSurvey(name: profileName, birthDate: birthDate, sex: gender, sportWith: sportWith, favoriteSport: favoriteSports, userID: usersID, age: age.year ?? 0 )
                        
                        toMainPage = false
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.mint)
                    //                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                }
            }
            .listRowSeparator(.hidden)
            .padding()
            .navigationTitle("What do you want to play?")
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar{
//                NavigationLink(destination: MoreDetailsSurveyView(mainViewModel: MainViewModel(container: CKContainer.default()), toMainPage: $toMainPage, favoriteSports: $selectedSport)){
//                    Text("Skip").foregroundColor(.mint)
//
//                }
//            }
            
            
        }
    }
}

//struct EditPreferredSportView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditPreferredSportView()
//    }
//}
