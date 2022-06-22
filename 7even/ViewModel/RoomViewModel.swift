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
}

class RoomViewModel: ObservableObject {
    
    private var database: CKDatabase
    private var container: CKContainer
    
    init(container: CKContainer) {
        self.container = container
        self.database = self.container.publicCloudDatabase
    }
    
    func createRoom(sport: String, location: String, minimumParticipant: Int, maximumParticipant: Int, price: Decimal, isPrivateRoom: Bool, startTime: Date, endTime: Date, sex: String, age: String, levelOfPlay: String){
        let record = CKRecord(recordType: RecordType.room.rawValue)
        let room = Room(sport: sport, location: location, minimumParticipant: minimumParticipant, maximumParticipant: maximumParticipant, price: price, isPrivateRoom: isPrivateRoom, startTime: startTime, endTime: endTime, sex: sex, age: age, levelOfPlay: levelOfPlay)
        record.setValuesForKeys(room.toDictionary())
        
        // saving record in database
        self.database.save(record) { returnedRecord, returnedError in
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
