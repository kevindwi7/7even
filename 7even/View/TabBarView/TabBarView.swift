//
//  TabBarView.swift
//  7even
//
//  Created by Kevin  Dwi on 24/06/22.
//

import SwiftUI
import CloudKit

struct TabBarView: View {
    let test = Color("F2F2F7")
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var vm: MainViewModel
    
    var body: some View {
        TabView{
            ListRoomView(vm: MainViewModel(container: CKContainer.default()), selectedSport: [])
                .tabItem{
                    Label("Explore", systemImage: "person.3")
                }
                    
            ListRoomEventView(vm: MainViewModel(container: CKContainer.default()))
                    .tabItem{
                        Label("My Room", systemImage: "calendar")
                        
                    }
            
            GroupChatView()
                .tabItem{
                    Label("Chat", systemImage: "bubble.left")
                }
            
            ProfileView(vm: MainViewModel(container: CKContainer.default()))
                .background(test)
                .tabItem{
                    Label("Profile", systemImage: "person")
                    
                }
            
          
            
        }
        .background(.white)
        .accentColor(.mint)
        .navigationBarBackButtonHidden(true)
        
    }
}

//struct TabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarView()
//    }
//}

extension Color {
    init?(_ hex: String) {
        var str = hex
        if str.hasPrefix("#") {
            str.removeFirst()
        }
        if str.count == 3 {
            str = String(repeating: str[str.startIndex], count: 2)
            + String(repeating: str[str.index(str.startIndex, offsetBy: 1)], count: 2)
            + String(repeating: str[str.index(str.startIndex, offsetBy: 2)], count: 2)
        } else if !str.count.isMultiple(of: 2) || str.count > 8 {
            return nil
        }
        guard let color = UInt64(str, radix: 16)
        else {
            return nil
        }
        if str.count == 2 {
            let gray = Double(Int(color) & 0xFF) / 255
            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)
        } else if str.count == 4 {
            let gray = Double(Int(color >> 8) & 0x00FF) / 255
            let alpha = Double(Int(color) & 0x00FF) / 255
            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)
        } else if str.count == 6 {
            let red = Double(Int(color >> 16) & 0x0000FF) / 255
            let green = Double(Int(color >> 8) & 0x0000FF) / 255
            let blue = Double(Int(color) & 0x0000FF) / 255
            self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)
        } else if str.count == 8 {
            let red = Double(Int(color >> 24) & 0x000000FF) / 255
            let green = Double(Int(color >> 16) & 0x000000FF) / 255
            let blue = Double(Int(color >> 8) & 0x000000FF) / 255
            let alpha = Double(Int(color) & 0x000000FF) / 255
            self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
        } else {
            return nil
        }
    }
}

