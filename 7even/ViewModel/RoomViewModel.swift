//
//  RoomViewModel.swift
//  7even
//
//  Created by Inez Amanda on 21/06/22.
//

import Foundation
import CloudKit

enum RecordType: String {
    case room = "Room"
    case survey = "Survey"
}

class RoomViewModel: ObservableObject {
    
    private var database: CKDatabase
    private var container: CKContainer
    
    init(container: CKContainer) {
        self.container = container
        self.database = self.container.publicCloudDatabase
    }
    
    func createRoom(host: String, sport: String, location: String, region: String, minimumParticipant: Int, maximumParticipant: Int, price: Decimal, isPrivateRoom: Bool, startTime: Date, endTime: Date, sex: String, age: [String], levelOfPlay: String){
        let record = CKRecord(recordType: RecordType.room.rawValue)
        let room = Room(host: host, sport: sport, location: location, region: region, minimumParticipant: minimumParticipant, maximumParticipant: maximumParticipant, price: price, isPrivateRoom: isPrivateRoom, startTime: startTime, endTime: endTime, sex: sex, age: age, levelOfPlay: levelOfPlay)
        record.setValuesForKeys(room.toDictionary())
        
        // saving record in database
        self.database.save(record) { returnedRecord, returnedError in
            print("Record: \(returnedRecord)")
            print("Error: \(returnedError)")
            
        }
    }
    
    func createSurvey(name: String, birthDate: Date, sex: String, sportWith: String, favoriteSport: String){
        let record = CKRecord(recordType: RecordType.survey.rawValue)
        let survey = Survey(name: name, birthDate: birthDate, sex: sex, sportWith: sportWith, favoriteSport: favoriteSport)
        record.setValuesForKeys(survey.toDictionary())
        
        self.database.save(record){ returnedRecord, returnedError in
            print("Record: \(returnedRecord)")
            print("Error: \(returnedError)")
        }
    }
    
    func fetchRoom(){
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RecordType.room.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedItems: [Room] = []
        
    }
}
