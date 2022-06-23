//
//  FavoriteSportSurveyView.swift
//  7even
//
//  Created by Kevin  Dwi on 23/06/22.
//

import SwiftUI

struct FavoriteSportSurveyView: View {
    @State var searchText = ""
    var body: some View {
        NavigationView{
            //            Text("").navigationBarTitleDisplayMode(.inline).toolbar{
            //                ToolbarItem(placement: .principal){
            //                    VStack{
            //                        HStack{
            //                            Spacer()
            //                            Text("What do you want to play?").frame(alignment:.center)
            //                            Spacer()
            //                            NavigationLink(destination: ContentView()){
            //                                Text("Next")
            //                            }
            //                        }
            //                    }
            //                }
            //            }
            VStack(alignment: .leading, spacing: 0){
                
                HStack{
                    Image("search")
                        .resizable()
                        .scaledToFit()
                        .frame(height:18)
                        .font(.system(size: 23, weight: .bold))
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $searchText)
                }.padding(.vertical,10)
                    .padding(.horizontal)
                    .background(Color.primary.opacity(0.05))
                    .cornerRadius(8)
                    .padding(.horizontal)
                HStack{
                    Text("Select Maximum 2 Sports")
                        .fontWeight(.bold)
                    Spacer()
                    
                }.padding()
                Spacer()
                
                ScrollView{
                    VStack(spacing:15){
                        ForEach(searchText == "" ? sports : sports.filter{$0.name.lowercased().contains(searchText.lowercased())}){ Sport in
                            FavoriteSportCardView(sport: Sport)
                        }
                        Spacer()
                    }.padding(.top,10)
                    Spacer()
                }
                Spacer()
                
                
                
            }
            
            
            
            
            //
        }
    }
}

struct FavoriteSportSurveyView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteSportSurveyView()
    }
}
