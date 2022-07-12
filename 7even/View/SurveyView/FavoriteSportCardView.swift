//
//  FavoriteSportCardView.swift
//  7even
//
//  Created by Kevin  Dwi on 28/06/22.
//

import SwiftUI

struct FavoriteSportCardView: View {
    var sport: Sport
    @State var searchText = ""
    @State var isCheck = false
    @State var selectedSport: [String]
    
    var body: some View {
        VStack{
            ForEach(searchText == "" ? sports : sports.filter{$0.name.lowercased().contains(searchText.lowercased())}, id: \.self){ sportss in
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
                        VStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 10).stroke(.mint, lineWidth: 2)
                                    .shadow(radius: 1)
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
                        }.padding(.vertical, 48)
                        
                    }else{
                        VStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 10).fill(.white)
                                    .shadow(radius: 1)
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
                            
                        }.padding()
                        
                        
                    }
                    
                }.padding(.vertical, 128)
            }
            //            ForEach(searchText == "" ? sports : sports.filter{$0.name.lowercased().contains(searchText.lowercased())}, id: \.self){ sport in
            
            //            }
            
            
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always),prompt: "Search")
    }
}

//struct FavoriteSportCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteSportCardView()
//    }
//}
