//
//  FavoriteSportCardView.swift
//  7even
//
//  Created by Kevin  Dwi on 23/06/22.
//

import SwiftUI

struct FavoriteSportCardView: View {
    var sport: Sport
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10).fill(.white)
                .shadow(radius: 5)
            VStack{
                HStack{
                    Text(sport.name)
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

struct FavoriteSportCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
