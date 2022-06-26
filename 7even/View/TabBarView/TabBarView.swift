//
//  TabBarView.swift
//  7even
//
//  Created by Kevin  Dwi on 24/06/22.
//

import SwiftUI
import CloudKit

struct TabBarView: View {
    var body: some View {
        TabView{
            ListRoomView(vm: MainViewModel(container: CKContainer.default()))
                .tabItem{
                    Label("Room", systemImage: "person.3")
                }
            
            SharingView()
                .tabItem{
                    Label("Sharing", systemImage: "star")
                    
                }
            ProfileView(vm: MainViewModel(container: CKContainer.default()))
                .tabItem{
                    Label("Profile", systemImage: "person")
                    
                }
        }
        .accentColor(.mint)
        .navigationBarBackButtonHidden(true)
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

