//
//  Room.swift
//  7even
//
//  Created by Inez Amanda on 21/06/22.
//

import Foundation
import CloudKit

struct Room {
    var id: CKRecord.ID?
    let sport: [String]
    let location: String
    let minimumParticipant: Int
    let maximumParticipant: Int
    let price: Decimal
    let isPrivateRoom: Bool
    let startTime: Date
    let endTime: Date
    let sex: String
    let age: String
    let levelOfPlay: String
//    let participant: [User.name]
    
    init(id: CKRecord.ID? = nil, sport: [String], location: String, minimumParticipant: Int, maximumParticipant: Int, price: Decimal, isPrivateRoom: Bool, startTime: Date, endTime: Date, sex: String, age: String, levelOfPlay: String) {
        self.id = id
        self.sport = sport
        self.location = location
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
