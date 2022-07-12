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
    @State var isCheck = false
    @State var isContentView = true
    
    @State var sports = [
        Sport(name: "Badminton", image: "badminton", isCheck: false),
        Sport(name: "Basketball",image: "basketball", isCheck: false),
        Sport(name: "Tennis", image: "tennis", isCheck: false),
        Sport(name: "Football",image: "soccer", isCheck: false),
        Sport(name: "Yoga", image: "yoga", isCheck: false),
        Sport(name: "Cycling", image: "cycling", isCheck: false),
        Sport(name: "Boxing", image: "boxing", isCheck: false)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack{
                Text("What sports do you want to play?")
                    .fontWeight(.bold)
                Spacer()
                
            }.padding()
            Spacer()
            
            ScrollView(.vertical){
                VStack(spacing:15){
                    //                (searchText == "" ? sports : sports.filter{$0.name.lowercased().contains(searchText.lowercased())}, id: \.self)
                    
                    ForEach(searchText == "" ? sports : sports.filter{$0.name.lowercased().contains(searchText.lowercased())}, id: \.id){ sport in
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
                            
                        }.padding(8)
                    }   .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always),prompt: "Search")
                    
                    
                    HStack{
                        NavigationLink(destination: MoreDetailsSurveyView(mainViewModel: MainViewModel(container: CKContainer.default()), toMainPage: $toMainPage, favoriteSports: $selectedSport)
                        ){
                            Text("Next")
                                .padding(.horizontal, 135)
                                .padding(.vertical, 10)
                                .background(.mint)
                                .cornerRadius(12)
                                .foregroundColor(.white)
                                .font(.headline)
                            
                            
                            
                            
                        }
                    }
                    Spacer()
                }
                .listRowSeparator(.hidden)
                .padding()
                .navigationTitle("Sport")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    NavigationLink(destination: MoreDetailsSurveyView(mainViewModel: MainViewModel(container: CKContainer.default()), toMainPage: $toMainPage, favoriteSports: $selectedSport)){
                        Text("Skip").foregroundColor(.mint)
                    }
                    
                    
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
