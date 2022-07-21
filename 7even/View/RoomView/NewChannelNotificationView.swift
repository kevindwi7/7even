//
//  NewChannelNotificationView.swift
//  7even
//
//  Created by Inez Amanda on 21/07/22.
//

import SwiftUI

struct NewChannelNotificationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var showScreen : Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(UIColor.systemGray6))
                .frame(width: 200, height: 100)
            
            VStack(alignment: .center) {
                HStack(alignment: .top) {
                    Spacer()
                    Button {
                        showScreen.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                            .font(.title3)
                            .padding(.trailing, 30)
                            
                    }
                }
                .padding(.top, -25)
                Text("New Message")
            }
        }
    }
}

//struct NewChannelNotificationView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewChannelNotificationView(sho)
//    }
//}
