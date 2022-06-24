//
//  FavoriteSportCardView.swift
//  7even
//
//  Created by Kevin  Dwi on 23/06/22.
//

import SwiftUI

struct FavoriteSportCardView: View {
    var sport: Sport
    
    @Binding var selectedName: String
    
    var body: some View {
        Button(action: {
            print("Tab")
            selectedName = sport.name
        }) {
            if selectedName == sport.name{
                ZStack{
                    RoundedRectangle(cornerRadius: 10).fill(.gray)
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
                    
            }
           
        }
        
        
    }
}

struct FavoriteSportCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
