//
//  FavoriteSportSurveyView.swift
//  7even
//
//  Created by Kevin  Dwi on 23/06/22.
//

import SwiftUI
import CloudKit

struct FavoriteSportSurveyView: View {
    @State var searchText = ""
    @State var sportName = ""
    @State var selectedFavoriteSportCard: String = ""
    
//    @State var selectedName:String = ""
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
                
                //                HStack{
                //                    Image("search")
                //                        .resizable()
                //                        .scaledToFit()
                //                        .frame(height:18)
                //                        .font(.system(size: 23, weight: .bold))
                //                        .foregroundColor(.gray)
                //
                //                    TextField("Search", text: $searchText)
                //                }.padding(.vertical,10)
                //                    .padding(.horizontal)
                //                    .background(Color.primary.opacity(0.05))
                //                    .cornerRadius(8)
                //                    .padding(.horizontal)
                HStack{
                    Text("Select Maximum 2 Sports")
                        .fontWeight(.bold)
                    Spacer()
                    
                }.padding()
                Spacer()
                
                VStack(spacing:15){
//                    List(selection: $selectedFavoriteSportCard){
                        ForEach(searchText == "" ? sports : sports.filter{$0.name.lowercased().contains(searchText.lowercased())}){ Sport in
                            
                            FavoriteSportCardView(sport: Sport, selectedName: $selectedFavoriteSportCard)
                            
                        }
//                    }.listStyle(.inset)
                    
                    
                    Spacer()
                }.padding(.top,10)
                Spacer()
            }
            
            
            
            
            
            
            
            
            
            //
        }
        .padding()
        .searchable(text: $searchText)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("What do you want to play?")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            NavigationLink(destination: MoreDetailsSurveyView(roomViewModel: RoomViewModel(container: CKContainer.default()))){
                Text("Next")
                
            }
        }
    }
}

struct FavoriteSportSurveyView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteSportSurveyView()
    }
}
