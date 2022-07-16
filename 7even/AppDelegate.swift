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
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        var config = ChatClientConfig(apiKeyString: APIKey)
        config.applicationGroupIdentifier = "MiniChallenge.inezamanda.-even"
        
        ChatClient.shared = ChatClient(config: config)
        
        let chatClient = ChatClient.shared
        
        streamChat = StreamChat(chatClient: chatClient!)
        connectUser(chatClient: chatClient!)
        return true
    }
    
    func connectUser(chatClient: ChatClient) {
        let authToken = UserDefaults.standard.object(forKey: "authToken") as? String
        let firstName = UserDefaults.standard.object(forKey: "firstName") as? String
        let lastName = UserDefaults.standard.object(forKey: "lastName") as? String

        print("AUTH TOKEN : \(authToken)")
        if(authToken != nil) {
            let token = try! Token(rawValue: authToken ?? "")
            vm.fetchUserID()
            // Use the chat client to connect the user. This gets the user ID, name and avatar
            
            chatClient.connectUser(
                userInfo: .init(id: vm.userID,
                                name: "\(firstName ?? "") \(lastName ?? "")",
                                imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/2/20/LukeTLJ.jpg")!),
                token: token
                
            ) { error in
                if let error = error {
                    // Some very basic error handling only logging the error.
                    log.error("connecting the user failed \(error)")
                    return
                }
            }
        }
    }
    
}
