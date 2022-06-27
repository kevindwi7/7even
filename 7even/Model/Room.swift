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
    let host: String
    var sport: String
    var location: String
    var address: String
    var region: String
    var minimumParticipant: Int
    var maximumParticipant: Int
    var price: Decimal
    var isPrivateRoom: Bool
    var startTime: Date
    var endTime: Date
    var sex: String
    var age: [String]
    var levelOfPlay: String
    let participant: [String]
    
    init(id: CKRecord.ID? = nil, host: String, sport: String, location: String, address: String, region: String, minimumParticipant: Int, maximumParticipant: Int, price: Decimal, isPrivateRoom: Bool, startTime: Date, endTime: Date, sex: String, age: [String], levelOfPlay: String, participant: [String]) {
        self.id = id
        self.host = host
        self.sport = sport
        self.location = location
        self.address = address
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
        self.participant = participant
    }
    
    func toDictionary() -> [String: Any]{
        return ["host": host, "sport": sport, "location": location, "address": address,"region": region, "minimumParticipant": minimumParticipant, "maximumParticipant": maximumParticipant, "price": price, "isPrivateRoom": isPrivateRoom, "startTime": startTime, "endTime": endTime, "sex": sex, "age": age, "levelOfPlay": levelOfPlay, "participant": participant]
    }
    
    static func fromRecord(_ record: CKRecord) -> Room? {
        guard
            let host = record.value(forKey: "host") as? String,
            let sport = record.value(forKey: "sport") as? String,
            let location = record.value(forKey: "location") as? String,
            let address = record.value(forKey: "address") as? String,
            let region = record.value(forKey: "region") as? String,
            let minimumParticipant = record.value(forKey: "minimumParticipant") as? Int,
            let maximumParticipant = record.value(forKey: "maximumParticipant") as? Int,
            let price = record.value(forKey: "price") as? Int,
            let isPrivateRoom = record.value(forKey: "isPrivateRoom") as? Bool,
            let startTime = record.value(forKey: "startTime") as? Date,
            let endTime = record.value(forKey: "endTime") as? Date,
            let sex = record.value(forKey: "sex") as? String,
            let age = record.value(forKey: "age") as? [String],
            let levelOfPlay = record.value(forKey: "levelOfPlay") as? String,
            let participant = record.value(forKey: "participant") as? [String]
        else {
            print("Tessss")
            return nil
        }
//        print(levelOfPlay)
        
        return Room(id: record.recordID, host: host, sport: sport, location: location, address: address, region: region, minimumParticipant: minimumParticipant, maximumParticipant: maximumParticipant, price: Decimal(price), isPrivateRoom: isPrivateRoom, startTime: startTime, endTime: endTime, sex: sex, age: age, levelOfPlay: levelOfPlay, participant: participant)
    }
}
