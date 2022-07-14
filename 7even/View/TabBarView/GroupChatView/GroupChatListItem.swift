//
//  GroupChatListItem.swift
//  7even
//
//  Created by Inez Amanda on 14/07/22.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

struct GroupChatListItem: View {
    
    let channel: ChatChannel
    let channelName: String
    let avatar: UIImage
    let channelDestination: (ChannelSelectionInfo) -> ChatChannelView<GroupChatViewFactory>
    let onItemTap: (ChatChannel) -> Void
    @Binding var selectedChannel: ChannelSelectionInfo?
    
    var body: some View {
        ZStack {
            GroupChatListItemView (
                channelName: channelName,
                avatar: avatar,
                lastMessageAt: channel.lastMessageAt ?? Date(),
                hasUnreadMessages: channel.unreadCount.messages > 0,
                lastMessage: channel.latestMessages.first?.text ?? "No messages",
                isMuted: channel.isMuted
            )
            .padding(.horizontal)
            .onTapGesture {
                onItemTap(channel)
            }
            
            NavigationLink(tag: channel.channelSelectionInfo, selection: $selectedChannel) {
                // use LazyView
                channelDestination(channel.channelSelectionInfo)
            } label: {
                EmptyView()
            }

        }
    }
}

