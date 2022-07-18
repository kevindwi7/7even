//
//  GroupChatView.swift
//  7even
//
//  Created by Inez Amanda on 13/07/22.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

struct GroupChatView: View {
    var body: some View {
//        ChatChannelListView(viewFactory: GroupChatViewFactory(), viewModel: <#T##ChatChannelListViewModel?#>, channelListController: <#T##ChatChannelListController?#>, title: <#T##String#>, onItemTap: <#T##((ChatChannel) -> Void)?##((ChatChannel) -> Void)?##(ChatChannel) -> Void#>, selectedChannelId: <#T##String?#>)
        ChatChannelListView(viewFactory: GroupChatViewFactory.shared, title: "Chat")
    }
}

struct GroupChatView_Previews: PreviewProvider {
    static var previews: some View {
        GroupChatView()
    }
}
