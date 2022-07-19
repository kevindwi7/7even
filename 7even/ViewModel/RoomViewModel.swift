//
//  RoomViewModel.swift
//  7even
//
//  Created by Inez Amanda on 26/06/22.
//

import Foundation
import CloudKit

struct RoomViewModel: Hashable, Identifiable {
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id.hashValue)
    }

    static func == (lhs: RoomViewModel, rhs: RoomViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let room: Room
    
    var id: CKRecord.ID? {
        room.id
    }
    
    var host: String {
        room.host
    }
    
    var sport: String {
        room.sport
    }
    
    var location: String {
        room.location
    }
    
    var minimumParticipant: Int {
        room.minimumParticipant
    }
    
    var maximumParticipant: Int {
        room.maximumParticipant
    }
    
    var price: Decimal {
        room.price
    }
    
    var isPrivateRoom: Bool {
        room.isPrivateRoom
    }
    
    var startTime: Date {
        room.startTime
    }
    
    var endTime: Date {
        room.endTime
    }
    
    var sex: String {
        room.sex
    }
    
    var age: [String] {
        room.age
    }
    
    var levelOfPlay: String {
        room.levelOfPlay
    }
    
    var participant: [String] {
        room.participant
    }
    
    var roomCode: String {
        room.roomCode
    }
    
    var isFinish: Bool{
        room.isFinish
    }
    
    var description: String {
        room.description
    }
    
    var name: String {
        room.name
    }
    
    var address: String {
        room.address
    }
    
    var region: String {
        room.region
    }
}
