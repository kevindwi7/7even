//
//  AppDelegate.swift
//  7even
//
//  Created by Inez Amanda on 13/07/22.
//

import StreamChat // The StreamChat class is the central object in the SwiftUI SDK
import StreamChatSwiftUI
import UIKit
import SwiftUI
import CloudKit


class AppDelegate: NSObject, UIApplicationDelegate {
    
    var vm = MainViewModel(container: CKContainer.default())
    var streamChat: StreamChat?
    var colors = ColorPalette()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        colors.background6 = UIColor(.mint)
        let appearance = Appearance(colors: colors)
        var config = ChatClientConfig(apiKeyString: APIKey)
        config.applicationGroupIdentifier = "MiniChallenge.inezamanda.-even"
        
        
        ChatClient.shared = ChatClient(config: config)
        
        let chatClient = ChatClient.shared
        
        streamChat = StreamChat(chatClient: chatClient!, appearance: appearance)
        connectUser(chatClient: chatClient!)
        return true
    }

    func connectUser(chatClient: ChatClient) {
        let firstName = UserDefaults.standard.object(forKey: "firstName") as? String
        let lastName = UserDefaults.standard.object(forKey: "lastName") as? String

//        print("INI AUTH TOKEN : \(authToken)")
//        let token = try! Token(rawValue: TokenValue)
        
        // Use the chat client to connect the user. This gets the user ID, name and avatar
        print("Current user ID: \(vm.userID)\n")
        chatClient.connectUser(
            userInfo: .init(id: "inez_amanda",
                            name: "\(firstName ?? "") \(lastName ?? "")",
                            imageURL: URL(string: "https://img.icons8.com/external-tanah-basah-glyph-tanah-basah/96/1ABC9C/external-users-user-tanah-basah-glyph-tanah-basah-3.png")!),
            token: .development(userId: vm.userID)
            
        ) { error in
            if let error = error {
                // Some very basic error handling only logging the error.
                log.error("connecting the user failed \(error)")
                return
            }
        }
    }
    
}
