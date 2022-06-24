//
//  TabBarView.swift
//  7even
//
//  Created by Kevin  Dwi on 24/06/22.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
            TabView{
                ListRoomView()
                    .tabItem{
                        Label("Room", systemImage: "person.3")
                    }
                SharingView()
                    .tabItem{
                        Label("Sharing", systemImage: "star")
                        
                    }
                ProfileView()
                    .tabItem{
                        Label("Profile", systemImage: "person")
                        
                    }
            }
    
            .navigationBarBackButtonHidden(true)
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
