//
//  GroupChatListViewFactory.swift
//  7even
//
//  Created by Inez Amanda on 14/07/22.
//

import Foundation
import StreamChatSwiftUI
import StreamChat
import SwiftUI
import CloudKit

class GroupChatViewFactory: ViewFactory {
    @Injected(\.chatClient) var chatClient: ChatClient
    
//    @StateObject var vm : MainViewModel = MainViewModel.MainVmShared
    
    private init() {}

    public static let shared = GroupChatViewFactory()
    
//    func makeChannelHeaderViewModifier(for channel: ChatChannel) -> some ChatChannelHeaderViewModifier {
//        CustomChatChannelModifier(channel: channel)
//    }

    func makeChannelListItem(
        channel: ChatChannel,
        channelName: String,
        avatar: UIImage,
        onlineIndicatorShown: Bool,
        disabled: Bool,
        selectedChannel: Binding<ChannelSelectionInfo?>,
        swipedChannelId: Binding<String?>,
        channelDestination: @escaping (ChannelSelectionInfo) -> ChatChannelView<GroupChatViewFactory>,
        onItemTap: @escaping (ChatChannel) -> Void,
        trailingSwipeRightButtonTapped: @escaping (ChatChannel) -> Void,
        trailingSwipeLeftButtonTapped: @escaping (ChatChannel) -> Void,
        leadingSwipeButtonTapped: @escaping (ChatChannel) -> Void) -> some View {
        GroupChatListItem(
            channel: channel,
            channelName: channelName,
            avatar: avatar,
            channelDestination: channelDestination,
            onItemTap: onItemTap,
            selectedChannel: selectedChannel
        )
    }
}
