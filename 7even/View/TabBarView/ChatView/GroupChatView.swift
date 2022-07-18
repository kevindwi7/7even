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
        ChatChannelListView(viewFactory: GroupChatViewFactory.shared, title: "Chat")
    }
}

struct GroupChatView_Previews: PreviewProvider {
    static var previews: some View {
        GroupChatView()
    }
}
