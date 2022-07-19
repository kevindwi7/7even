//
//  MainViewModel.swift
//  7even
//
//  Created by Inez Amanda on 21/06/22.
//

import Foundation
import CloudKit
import Combine
import UIKit
import StreamChat
import StreamChatSwiftUI
import SwiftUI
import JWTKit

enum RecordType: String {
    case room = "Room"
    case survey = "Survey"
    case user = "UsersData"
}

final class MainViewModel: ObservableObject {
    
    private var database: CKDatabase
    private var container: CKContainer
    
    @Published var rooms: [RoomViewModel] = []
    @Published var surveys: [SurveyViewModel] = []
    @Published var channels: [ChatChannel] = []
    @Published var isSignedInToiCloud: Bool = false
    @Published var userID: String = ""
    @Published var recentlyCreatedRoomID: String = ""
    @Published var hasUpdated: Bool = false
    
    let objectWillChange = PassthroughSubject<(), Never>()
    
    init(container: CKContainer) {
        self.container = container
        self.database = self.container.publicCloudDatabase
        iCloudUserIDAsync()
    }
    
    func iCloudUserIDAsync() {
        // FETCH ID OF DEVICE ACCOUNT
        container.fetchUserRecordID { returnedID, returnedError in
            if let returnedError = returnedError {
                print("Error: \(returnedError)")
            } else {
                if let returnedID = returnedID?.recordName {
                    self.isSignedInToiCloud = true
                    self.userID = returnedID
//                    print("uid : \(returnedID)")
                }
            }
        }
    }
    
    func fetchUserID() {
        // FETCH ID OF REGISTRATED ACCOUNT FROM DB
        let referenceField = "userID"
        let uid = self.userID
        let refID = CKRecord.ID(recordName: uid)
        let ref = CKRecord.Reference(recordID: refID, action: .none)
        let predicate = NSPredicate(format: "iCloudID == %@", self.userID)
        let query = CKQuery(recordType: RecordType.user.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        self.database.fetch(withQuery: query) { result in
            switch result {
            case .success(let result):
                result.matchResults.compactMap { $0.1 }
                    .forEach {
                        switch $0 {
                        case .success(let record):
                            self.userID = record.recordID.recordName
                            print("UID DISINI : \(self.userID)")
                        case .failure(let error):
                            print(error)
                        }
                    }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func generateToken(id : String) -> String {
        // Signs and verifies JWTs
        let signers = JWTSigners()
        // Add HMAC with SHA-256 signer.
        signers.use(.hs256(key: APIKey))
        // Create a new instance of our JWTPayload
        let payload = Payload(
            subject: "Returned Token",
            expiration: .init(value: .distantFuture),
            userID: id
        )
        
        // Sign the payload, returning a JWT.
        let jwt = try? signers.sign(payload)
        print("--------- \(jwt) ---------")
        return jwt ?? ""
    }
    
    func createRoom(host: String, sport: String, location: String, address: String, minimumParticipant: Int, maximumParticipant: Int, price: Decimal, isPrivateRoom: Bool, startTime: Date, endTime: Date, sex: String, age: [String], levelOfPlay: String, participant: [String], roomCode: String, isFinish: Bool, description: String, name: String, region: String, completionHandler:  @escaping (_ recentRoomID: String) -> Void){
        let record = CKRecord(recordType: RecordType.room.rawValue)
        let room = Room(host: host, sport: sport, location: location, address: address, minimumParticipant: minimumParticipant, maximumParticipant: maximumParticipant, price: price, isPrivateRoom: isPrivateRoom, startTime: startTime, endTime: endTime, sex: sex, age: age, levelOfPlay: levelOfPlay, participant: participant, roomCode: roomCode, isFinish: isFinish, description: description, name: name, region: region)
        
        record.setValuesForKeys(room.toDictionary())
        
        // saving record in database
        self.database.save(record) { returnedRecord, returnedError in
            if let returnedError = returnedError {
                print("Error: \(returnedError)")
            } else {
                if let returnedRecord = returnedRecord {
                    if let room = Room.fromRecord(returnedRecord) {
                        DispatchQueue.main.async {
                            self.rooms.append(RoomViewModel(room: room))
                            self.objectWillChange.send()
                        }
                        self.recentlyCreatedRoomID = room.id?.recordName ?? ""
                        print("---- ROOM ID NYA INI : \(self.recentlyCreatedRoomID) -----")
                        completionHandler(self.recentlyCreatedRoomID)
                    }
                }
            }
        }
    }
    
    func fetchRoom(){
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RecordType.room.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedRooms: [Room] = []
        
        self.database.fetch(withQuery: query) { result in
            switch result {
            case .success(let result):

                result.matchResults.compactMap { $0.1 }
                    .forEach {
                        switch $0 {
                        case .success(let record):
                            
                            if let room = Room.fromRecord(record) {
                                returnedRooms.append(room)
                            }
//                            print(returnedRooms)
                        case .failure(let error):
                            print(error)
                        }
                    }
                
                DispatchQueue.main.async {
                    self.rooms = returnedRooms.map(RoomViewModel.init)
//                    defer {
//                        self.objectWillChange.send()
//                    }
                    self.objectWillChange.send()
//                    print("\(self.rooms)")
                }

            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchDetailRoom(room: RoomViewModel){
        
        let recordId = room.id

        database.fetch(withRecordID: recordId!) { returnedRecord, error  in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }
                guard let record = returnedRecord else { return }
            
            }
        }
    }
    
    func updateRoomMember(room: RoomViewModel, participantID: String, command: String, completionHandler:  @escaping () -> Void){

        var newParticipant =  [String]()
        newParticipant.insert(contentsOf: room.participant, at: 0)
        
        let recordId = room.id
        let host = room.host
        let sport = room.sport
        let location = room.location
        let address = room.address
        let region = room.region
        let minimumParticipant = room.minimumParticipant
        let maximumParticipant = room.maximumParticipant
        let price = room.price
        let isPrivateRoom = room.isPrivateRoom
        let startTime = room.startTime
        let endTime = room.endTime
        let sex = room.sex
        let age = room.age
        let levelOfPlay = room.levelOfPlay
        let roomCode = room.roomCode
        let isFinish = room.isFinish
        let description = room.description
        let name = room.name
        
        if(command == "join") {
            if( !(newParticipant.contains(participantID))){
                if(participantID != "" || !(participantID.isEmpty) ){
                    newParticipant.append(participantID)
                    print("masukk")
                }
            }
        } else if (command == "leave") {
            if(newParticipant.contains(participantID)){
                if let index = newParticipant.firstIndex(of: participantID) {
                    print("Leave Room : \(newParticipant[index])")
                    newParticipant.remove(at: index)
                }
            }
        }
        
        newParticipant.removeAll(where: { $0 == "" })
        
        print(newParticipant)
        database.fetch(withRecordID: recordId!) { returnedRecord, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if let error = error {
                    print(error)
                }
                guard let record = returnedRecord else { return }
                
                record["participant"] = newParticipant as CKRecordValue
                self.database.save(record) { record, error in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if let error = error {
                            print(error)
                            completionHandler()
                        }
                        guard let record = returnedRecord else { return }
                        let id = record.recordID
                        guard let participant = record["participant"] as? [String] else { return }
                        let element = RoomViewModel(room: Room(id: id, host: host, sport: sport, location: location, address: address, minimumParticipant: minimumParticipant, maximumParticipant: maximumParticipant, price: price, isPrivateRoom: isPrivateRoom, startTime: startTime, endTime: endTime, sex: sex, age: age, levelOfPlay: levelOfPlay, participant: participant, roomCode: roomCode, isFinish: isFinish, description: description, name: name, region: region))
//                        print(element)
                        self.hasUpdated = true
                        completionHandler()
                    }
                }
            }
        }
    }
    
    func finishRoom(room: RoomViewModel, completionHandler:  @escaping () -> Void){
        let recordId = room.id
        let host = room.host
        let sport = room.sport
        let location = room.location
        let address = room.address
        let region = room.region
        let minimumParticipant = room.minimumParticipant
        let maximumParticipant = room.maximumParticipant
        let price = room.price
        let isPrivateRoom = room.isPrivateRoom
        let startTime = room.startTime
        let endTime = room.endTime
        let sex = room.sex
        let age = room.age
        let levelOfPlay = room.levelOfPlay
        let roomCode = room.roomCode
        let description = room.description
        let name = room.name
        let participant = room.participant
        
        let isFinish = true
        
        database.fetch(withRecordID: recordId!) { returnedRecord, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if let error = error {
                    print(error)
                }
                guard let record = returnedRecord else { return }
                
                record["isFinish"] = isFinish as CKRecordValue
                self.database.save(record) { record, error in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if let error = error {
                            print(error)
                        }
                        guard let record = returnedRecord else { return }
                        let id = record.recordID
                        guard let finishStatus = record["isFinish"] as? Bool else { return }
                        let element = RoomViewModel(room: Room(id: id, host: host, sport: sport, location: location, address: address, minimumParticipant: minimumParticipant, maximumParticipant: maximumParticipant, price: price, isPrivateRoom: isPrivateRoom, startTime: startTime, endTime: endTime, sex: sex, age: age, levelOfPlay: levelOfPlay, participant: participant, roomCode: roomCode, isFinish: finishStatus, description: description, name: name, region: region))
//                        print(element)
                        completionHandler()
                    }
                }
            }
        }
    }
    
    func deleteRoom(room: RoomViewModel, completionHandler:  @escaping () -> Void){
        let recordId = room.id
        database.delete(withRecordID: recordId!) { deletedRecordId, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                } else {
                    self.fetchRoom()
                    completionHandler()
                }
                print("here")
            }
        }
    }
    
    func createSurvey(name: String, birthDate: Date, sex: String, sportWith: String, favoriteSport: [String] ,userID: String, age: Int){
        let record = CKRecord(recordType: RecordType.survey.rawValue)
        let survey = Survey(name: name, birthDate: birthDate, sex: sex, sportWith: sportWith, favoriteSport: favoriteSport,userID: userID, age: age)
        record.setValuesForKeys(survey.toDictionary())
        
        self.database.save(record){ returnedRecord, returnedError in
            if let returnedError = returnedError {
                print("Error: \(returnedError)")
            } else {
                if let returnedRecord = returnedRecord {
                    if let survey = Survey.fromRecord(returnedRecord) {
                        DispatchQueue.main.async {
                            self.surveys.append(SurveyViewModel(survey: survey))
                            self.objectWillChange.send()
                            self.fetchSurvey()
//                            print("Record: \(returnedRecord)")
                        }
                    }
                }
            }
        }
    }
    
    func editSurvey(item: SurveyViewModel, completion: @escaping (Result<SurveyViewModel, Error>) -> ()){
        guard let recordID = item.id else {return}
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID){ (record, err) in
            DispatchQueue.main.sync {
                if let err = err {
                    print(err)
                }
                guard let record = record else {return}
                record["name"] = item.name as CKRecordValue
                record["favoriteSport"] = item.favoriteSport as CKRecordValue
                record["sportWith"] = item.sportWith as CKRecordValue
                record["age"] = item.age as CKRecordValue
                record["birthDate"] = item.birthDate as CKRecordValue
                record["sex"] = item.sex as CKRecordValue
                
                CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID){ (record, err) in
                    if let err = err {
                        print(err)
                    }
                    guard let record = record else { return }
                    let id = record.recordID
                    guard let name = record["name"] as? String else {return}
                    guard let favoriteSport = record["favoriteSport"] as? String else {return}
                    guard let sportWith = record["sportWith"] as? String else {return}
                    guard let age = record["age"] as? Int else {return}
                    guard let birthDate = record["birthDate"] as? Date else {return}
                    guard let sex = record["sex"] as? String else {return}
                    guard let userID = record["userID"] as? String else {return}
                    
                    let element = SurveyViewModel(survey: Survey(name: name, birthDate: birthDate, sex: sex, sportWith: sportWith, favoriteSport: [favoriteSport], userID: userID, age: age))
                    
                    completion(.success(element))
                }
               
            }
        }
        
    }
    
    func updateItem(item: SurveyViewModel, name: String, birthDate: Date, sex: String, sportWith: String, favoriteSport: [String],userID: String, age: Int){
        let recordID = item.id
        let name = item.name
        let birthDate = item.birthDate
        let sex = item.sex
        let sportWith = item.sportWith
        let favoriteSport = item.favoriteSport
        let userID = item.userID
        let age = item.age
        
        database.fetch(withRecordID: recordID!) { returnedRecord, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if let error = error {
                    print(error)
                }
                guard let record = returnedRecord else { return }
                
                record["name"] = name as CKRecordValue
                record["favoriteSport"] = favoriteSport as CKRecordValue
                record["sportWith"] = sportWith as CKRecordValue
                record["age"] = age as CKRecordValue
                record["birthDate"] = birthDate as CKRecordValue
                record["sex"] = sex as CKRecordValue
                record["userID"] = userID as CKRecordValue
                
                self.database.save(record) { record, error in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if let error = error {
                            print(error)
                        }
                        guard let record = returnedRecord else { return }
                        let id = record.recordID
                        
                        guard let name = record["name"] as? String else {return}
                        guard let favoriteSport = record["favoriteSport"] as? [String] else {return}
                        guard let sportWith = record["sportWith"] as? String else {return}
                        guard let age = record["age"] as? Int else {return}
                        guard let birthDate = record["birthDate"] as? Date else {return}
                        guard let sex = record["sex"] as? String else {return}
                        guard let userID = record["userID"] as? String else {return}
                        
                        let element = SurveyViewModel(survey: Survey(id: id, name: name, birthDate: birthDate, sex: sex, sportWith: sportWith, favoriteSport: favoriteSport, userID: userID, age: age))
                        
//                        let element = RoomViewModel(room: Room(id: id, host: host, sport: sport, location: location, address: address, region: region, minimumParticipant: minimumParticipant, maximumParticipant: maximumParticipant, price: price, isPrivateRoom: isPrivateRoom, startTime: startTime, endTime: endTime, sex: sex, age: age, levelOfPlay: levelOfPlay, participant: participant, roomCode: roomCode))
//                        print(element)
                    }
                }
            }
        }
        
    }
    
    
    
    func fetchSurvey(){
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RecordType.survey.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedSurveys: [Survey] = []
        

        self.database.fetch(withQuery: query) { result in
            switch result {
            case .success(let result):

                result.matchResults.compactMap { $0.1 }
                    .forEach {
                        switch $0 {
                        case .success(let record):
                            if let survey = Survey.fromRecord(record) {
                                returnedSurveys.append(survey)
                            }
//                            print(returnedSurveys)
                        case .failure(let error):
                            print(error)
                        }
                    }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.surveys = returnedSurveys.map(SurveyViewModel.init)
                    self.objectWillChange.send()
//                    print("31 \(self.surveys)")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func createChannel(channelName: String, roomID: String) throws {
        /// 1: Create a `ChannelId` that represents the channel you want to create.
        let cid = ChannelId(type: .messaging, id: roomID)
        print("CID: \(cid)")
        /// 2: Use the `ChatClient` to create a `ChatChannelController` with the `ChannelId` and a list of user ids
        let controller = try ChatClient.shared.channelController(
            createChannelWithId: cid,
            name: channelName,
            imageURL: nil,
            isCurrentUserMember: true
        )
        
        /// 3: Call `ChatChannelController.synchronize` to create the channel.
        controller.synchronize { error in
            if let error = error {
                /// 4: Handle possible errors
                print(error)
            } else if let channel = controller.channel {
                self.channels.append(channel)
                print("Success create channel")
            }
        }
    }
    
    func deleteChannel(room: RoomViewModel) throws {
        let id = room.id?.recordName ?? ""
        let controller = try ChatClient.shared.channelController(for: .init(type: .messaging, id: id))

        controller.deleteChannel { error in
            if let error = error {
                // handle error
                print(error)
            }
        }
    }
    
    func addMemberToChannel(room: RoomViewModel, userID: String) throws {
        let id = room.id?.recordName ?? ""
        var userIDs: [String] = [""]
        userIDs[0] = userID
        
        print(userIDs)
        let controller = try ChatClient.shared.channelController(for: .init(type: .messaging, id: id))

        controller.addMembers(userIds: Set(userIDs))
        print("Success add member to channel")
//        controller.removeMembers(userIds: ["tommaso"])
    }
    
    func removeMemberFromChannel(room: RoomViewModel, userID: String) throws {
        let id = room.id?.recordName ?? ""
        var userIDs: [String] = [""]
        userIDs[0] = userID
        
        print(userIDs)
        let controller = try ChatClient.shared.channelController(for: .init(type: .messaging, id: id))

        controller.removeMembers(userIds: Set(userIDs))
        print("Success remove member from channel")
    }
    
    func hideChannel(room: RoomViewModel) throws {
        let id = room.id?.recordName ?? ""
        let controller = try ChatClient.shared.channelController(for: .init(type: .messaging, id: id))

        controller.hideChannel(clearHistory: false) { error in
            if let error = error {
                // handle error
                print(error)
            }
        }
    }

}

