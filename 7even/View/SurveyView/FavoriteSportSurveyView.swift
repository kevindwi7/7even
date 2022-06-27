//
//  FavoriteSportSurveyView.swift
//  7even
//
//  Created by Kevin  Dwi on 23/06/22.
//

import SwiftUI
import CloudKit

struct FavoriteSportSurveyView: View {
    @State var selectedSport: [String]
    @State var sportName = ""
    @State var searchText = ""
    //    @State var selectedFavoriteSportCard: [String]
    @Binding var toMainPage: Bool
    @State var isCheckes = false
    @State var isContentView = true
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack{
                Text("Select Maximum 2 Sports")
                    .fontWeight(.bold)
                Spacer()
                
            }.padding()
            Spacer()
            
            VStack(spacing:15){
                List (searchText == "" ? sports : sports.filter{$0.name.lowercased().contains(searchText.lowercased())}, id: \.self){ sport in
                    Button(action: {
                        for index in selectedSport {
                            if (index == sport.name){
                                // MARK BUTTON AS CHECKED
                                if let matchingIndex = sports.firstIndex(where: { $0.id == sport.id }) {
                                    sports[matchingIndex].isCheckes = true
                                }
                            }
                        }
                        
                        if let matchingIndex = sports.firstIndex(where: { $0.id == sport.id }) {
                            sports[matchingIndex].isCheckes.toggle()
                            
                            if(sports[matchingIndex].isCheckes == true) {
                                self.selectedSport.append(sport.name)
                            } else {
                                let match = self.selectedSport.firstIndex(where: { $0 == sport.name})
                                self.selectedSport.remove(at: match ?? 0)
                            }
                        }
                        print(selectedSport)
                    }){
                        
                        if(sport.isCheckes == true){
                            ZStack{
                                RoundedRectangle(cornerRadius: 10).fill(Color.red)
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
                            }.padding(.horizontal)
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
                            }.padding(.horizontal)
                                .listRowSeparator(.hidden)
                        }
                        
                    }.listRowSeparator(.hidden)
                    
                        .listRowSeparator(.hidden)
                        .listStyle(.plain)
                    
                    
                    Spacer()
                }.listStyle(.plain)
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always),prompt: "Search")
                    .padding(.top,10)
                Spacer()
            }.listRowSeparator(.hidden)
            
                .padding()
                .navigationTitle("What do you want to play?")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    NavigationLink(destination: MoreDetailsSurveyView(mainViewModel: MainViewModel(container: CKContainer.default()), toMainPage: $toMainPage, favoriteSports: $selectedSport)){
                        Text("Next")
                        
                    }
                }
            
            
        }
        
        
    }
}
//struct FavoriteSportSurveyView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteSportSurveyView()
//    }
//}
