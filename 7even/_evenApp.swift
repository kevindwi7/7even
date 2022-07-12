//
//  _evenApp.swift
//  7even
//
//  Created by Kevin  Dwi on 20/06/22.
//

import SwiftUI
import CloudKit

@main
struct _evenApp: App {

    var body: some Scene {
        WindowGroup {
//            FavoriteSportSurveyView()
            TabBarView(vm: MainViewModel(container: CKContainer.default()))
//            TabBarView()
//            CreateRoomView(vm: MainViewModel(container: CKContainer.default()))
            
        }
    }
}
