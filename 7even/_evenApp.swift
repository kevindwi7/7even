//
//  _evenApp.swift
//  7even
//
//  Created by Kevin  Dwi on 20/06/22.
//

import SwiftUI
import CloudKit
import StreamChat
import StreamChatSwiftUI

@main
struct _evenApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    @StateObject var vm = MainViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            TabBarView(vm: MainViewModel(container: CKContainer.default()))
//                .environmentObject(appDelegate.vm)
        }
    }
}
