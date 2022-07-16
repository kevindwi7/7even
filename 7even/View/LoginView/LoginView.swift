//
//  LoginView.swift
//  7even
//
//  Created by Kevin  Dwi on 23/06/22.
//

import SwiftUI
import AuthenticationServices
import CloudKit
import StreamChat // The StreamChat class is the central object in the SwiftUI SDK
import StreamChatSwiftUI
import UIKit

struct LoginView: View {
    @AppStorage("login") private var login = false
    @Binding var toMainPage: Bool
    @State var isContentView = true
    @StateObject var vm: MainViewModel
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    
    var body: some View {
        VStack{
            Image("benefit")
                .resizable()
                .scaledToFit()
                .frame(height:200)
            //                Text("beneFIT")
            Spacer()
            
            let userID = UserDefaults.standard.object(forKey: "userID") as? String
            
            if (!login && (userID == nil)) {
                Spacer()
                
                // If login = false and userID is not exist,
                // Show Sign in with Apple Button.
                SignInWithAppleButton(
                    // Request User FullName and Email
                    onRequest: { request in
                        // You can change them if needed.
                        request.requestedScopes = [.fullName, .email]
                    },
                    // Once user complete, get result
                    onCompletion: { result in
                        // Switch result
                        switch result {
                            // Auth Success
                        case .success(let authResults):
                            
                            switch authResults.credential {
                            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                let userID = appleIDCredential.user
                                if let firstName = appleIDCredential.fullName?.givenName,
                                   let lastName = appleIDCredential.fullName?.familyName,
                                   let email = appleIDCredential.email,
                                   let token = appleIDCredential.identityToken {
                                    // For New user to signup, and
                                    // save the 3 records to CloudKit
                                    let record = CKRecord(recordType: "UsersData", recordID: CKRecord.ID(recordName: userID))
                                    record["email"] = email
                                    record["firstName"] = firstName
                                    record["lastName"] = lastName
                                    record["iCloudID"] = vm.userID
                                    // Save to local
                                    UserDefaults.standard.set(email, forKey: "email")
                                    UserDefaults.standard.set(firstName, forKey: "firstName")
                                    UserDefaults.standard.set(lastName, forKey: "lastName")
                                    let publicDatabase = CKContainer.default().publicCloudDatabase
                                    publicDatabase.save(record) { (_, _) in
                                        UserDefaults.standard.set(record.recordID.recordName, forKey: "userID")
                                    }
                                    // Change login state
                                    self.login = true
                                    let jwt = vm.generateToken(id: userID)
                                    UserDefaults.standard.set(jwt, forKey: "authToken")
                                    print("--------- \(jwt) ---------")
                                    
                                    var config = ChatClientConfig(apiKeyString: APIKey)
                                    config.applicationGroupIdentifier = "MiniChallenge.inezamanda.-even"
                                    
                                    ChatClient.shared = ChatClient(config: config)
                                    
                                    let chatClient = ChatClient.shared
                                    
                                    appDelegate?.connectUser(chatClient: chatClient!)
                                } else {
                                    // For returning user to signin,
                                    // fetch the saved records from Cloudkit
                                    let publicDatabase = CKContainer.default().publicCloudDatabase
                                    publicDatabase.fetch(withRecordID: CKRecord.ID(recordName: userID)) { (record, error) in
                                        if let fetchedInfo = record {
                                            let email = fetchedInfo["email"] as? String
                                            let firstName = fetchedInfo["firstName"] as? String
                                            let lastName = fetchedInfo["lastName"] as? String
                                            // Save to local
                                            UserDefaults.standard.set(userID, forKey: "userID")
                                            UserDefaults.standard.set(email, forKey: "email")
                                            UserDefaults.standard.set(firstName, forKey: "firstName")
                                            UserDefaults.standard.set(lastName, forKey: "lastName")
                                            // Change login state
                                            self.login = true
                                        }
                                    }
                                }
                                
                                // default break (don't remove)
                            default:
                                break
                            }
                        case .failure(let error):
                            print("failure", error)
                        }
                    }
                )
                .signInWithAppleButtonStyle(.black) // Button Style
                .frame(width:250,height:50)         // Set Button Size (Read iOS 14 beta 7 release note)
                Spacer()
            }else{
                NavigationLink(destination: FavoriteSportSurveyView( selectedSport: [], toMainPage: $toMainPage)
                ){
                    Text("SignIn")
                }
            }
        }     
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
