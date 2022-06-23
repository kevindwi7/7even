//
//  Room.swift
//  7even
//
//  Created by Inez Amanda on 21/06/22.
//

import Foundation
import CloudKit

struct Room {
    let id: CKRecord.ID?
    var sport: String
    var location: String
    var region: String
    var minimumParticipant: Int
    var maximumParticipant: Int
    var price: Decimal
    var isPrivateRoom: Bool
    var startTime: Date
    var endTime: Date
    var sex: String
    var age: String
    var levelOfPlay: String
//    let participant: [User]
    
    init(id: CKRecord.ID? = nil, sport: String, location: String, region: String, minimumParticipant: Int, maximumParticipant: Int, price: Decimal, isPrivateRoom: Bool, startTime: Date, endTime: Date, sex: String, age: String, levelOfPlay: String) {
        self.id = id
        self.sport = sport
        self.location = location
        self.region = region
        self.minimumParticipant = minimumParticipant
        self.maximumParticipant = maximumParticipant
        self.price = price
        self.isPrivateRoom = isPrivateRoom
        self.startTime = startTime
        self.endTime = endTime
        self.sex = sex
        self.age = age
        self.levelOfPlay = levelOfPlay
    }
    
    func toDictionary() -> [String: Any]{
        return ["sport": sport, "location": location, "minimumParticipant": minimumParticipant, "maximumParticipant": maximumParticipant, "price": price, "isPrivateRoom": isPrivateRoom, "startTime": startTime, "endTime": endTime, "sex": sex, "age": age, "levelOfPlay": levelOfPlay]
    }
}
