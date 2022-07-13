//
//  MainViewModel.swift
//  7even
//
//  Created by Inez Amanda on 21/06/22.
//

import Foundation
import CloudKit
import Combine

enum RecordType: String {
    case room = "Room"
    case survey = "Survey"
}

final class MainViewModel: ObservableObject {
    
    private var database: CKDatabase
    private var container: CKContainer
    
    @Published var rooms: [RoomViewModel] = []
    @Published var surveys: [SurveyViewModel] = []
    
    let objectWillChange = PassthroughSubject<(), Never>()
    
    init(container: CKContainer) {
        self.container = container
        self.database = self.container.publicCloudDatabase
    }
    
    func createRoom(host: String, sport: String, location: String, address: String, region: String, minimumParticipant: Int, maximumParticipant: Int, price: Decimal, isPrivateRoom: Bool, startTime: Date, endTime: Date, sex: String, age: [String], levelOfPlay: String, participant: [String], roomCode: String, isFinish: Bool, description: String, name: String){
        let record = CKRecord(recordType: RecordType.room.rawValue)
        let room = Room(host: host, sport: sport, location: location, address: address, region: region, minimumParticipant: minimumParticipant, maximumParticipant: maximumParticipant, price: price, isPrivateRoom: isPrivateRoom, startTime: startTime, endTime: endTime, sex: sex, age: age, levelOfPlay: levelOfPlay, participant: participant, roomCode: roomCode, isFinish: isFinish, description: description, name: name)
        
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
    
    func updateItem(room: RoomViewModel, participantID: String, command: String){

        var newParticipant: [String] = [""]
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
                    newParticipant.remove(at: index)
                    print(newParticipant[index])
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
                        }
                        guard let record = returnedRecord else { return }
                        let id = record.recordID
                        guard let participant = record["participant"] as? [String] else { return }
                        let element = RoomViewModel(room: Room(id: id, host: host, sport: sport, location: location, address: address, region: region, minimumParticipant: minimumParticipant, maximumParticipant: maximumParticipant, price: price, isPrivateRoom: isPrivateRoom, startTime: startTime, endTime: endTime, sex: sex, age: age, levelOfPlay: levelOfPlay, participant: participant, roomCode: roomCode, isFinish: isFinish, description: description, name: name))
//                        print(element)
                    }
                }
            }
        }
    }
    
    func deleteRoom(_ recordId: CKRecord.ID){
        database.delete(withRecordID: recordId) { deletedRecordId, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                } else {
                    self.fetchRoom()
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

}

