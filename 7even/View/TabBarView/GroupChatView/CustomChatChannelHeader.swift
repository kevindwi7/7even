//
//  CustomChatChannelHeader.swift
//  7even
//
//  Created by Inez Amanda on 17/07/22.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI
import CloudKit

struct CustomChatChannelHeader: ToolbarContent {

    var channelName: String
    public var channel: ChatChannel
//    @StateObject var vm: MainViewModel
    
    var onTapTrailing: () -> ()

    var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(channelName)
        }

        ToolbarItem(placement: .navigationBarTrailing) {
//            NavigationLink(destination: DetailRoomView(vm: vm, room: $vm.rooms.first(where: {$0.id?.recordName == channel.cid.id})! )) {
//                Image(systemName: "info.circle")
//                    .resizable()
//            }
            

            Button {
                onTapTrailing()
            } label: {
//                Text(vm.MainVmShared?.rooms.first?.id?.recordName ?? "GAADA")
                Image(systemName: "info.circle")
                    .resizable()
            }
            
        }
    }
}
