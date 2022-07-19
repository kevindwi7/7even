//
//  JoinedRoomNotificationView.swift
//  7even
//
//  Created by Inez Amanda on 19/07/22.
//

import SwiftUI
import UIKit

struct JoinedRoomNotificationView: View {
//    @Binding var open: Bool
       
    var body: some View {
        ZStack {
            VStack {
                
            }
            ZStack(alignment: .bottomTrailing) {
                Image(systemName: "bubble.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 56.8, height: 56.8)
                    .foregroundColor(.mint)
    //            ZStack {
    //                Image(systemName: "pentagon.fill")
    //                    .resizable()
    //                    .scaledToFit()
    //                    .frame(width: 25, height: 25)
    //                    .foregroundColor(.yellow)
    //                Text("5.0")
    //                    .font(.caption2)
    //            }
            }
        }
        
    }
}

struct JoinedRoomNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        JoinedRoomNotificationView()
    }
}

