//
//  GroupChatListItemView.swift
//  7even
//
//  Created by Inez Amanda on 14/07/22.
//

import SwiftUI

struct GroupChatListItemView: View {
    
    let channelName: String
    let avatar: UIImage
    let lastMessageAt: Date
    let hasUnreadMessages: Bool
    let lastMessage: String
    let isMuted: Bool
    
    var lastMessageStamp: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: lastMessageAt)
    }
    
    var body: some View {
        HStack {
            
            Image(uiImage: avatar)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(channelName)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    Spacer()
                    HStack(spacing: 10) {
                        Text(lastMessageStamp)
                            .foregroundColor(.secondary)
//                        Image(systemName: "chevron.right")
//                            .foregroundColor(.secondary)
                    }
                    .font(.subheadline)
                }
                
                HStack(spacing: 4) {
                    Text(lastMessage)
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, minHeight: 40, alignment: .topLeading)
                    if hasUnreadMessages {
                        Circle()
                            .foregroundColor(.mint)
                            .frame(width: 12, height: 12)
                            .padding(.top, 4)
                    }
                        
                }
                
            }
        }
        .padding(.vertical, 4)
        .background(Color(uiColor: .systemBackground))
    }
}

struct GroupChatListItemView_Previews: PreviewProvider {
    static var previews: some View {
        GroupChatListItemView(channelName: "Test", avatar: UIImage(named: "Oval")!, lastMessageAt: Date(), hasUnreadMessages: true, lastMessage: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", isMuted: false)
            .previewLayout(.fixed(width: 400, height: 120))
            .padding()
    }
}
