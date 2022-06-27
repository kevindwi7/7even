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
    
    func createRoom(host: String, sport: String, location: String, address: String, region: String, minimumParticipant: Int, maximumParticipant: Int, price: Decimal, isPrivateRoom: Bool, startTime: Date, endTime: Date, sex: String, age: [String], levelOfPlay: String, participant: [String], roomCode: String){
        let record = CKRecord(recordType: RecordType.room.rawValue)
        let room = Room(host: host, sport: sport, location: location, address: address, region: region, minimumParticipant: minimumParticipant, maximumParticipant: maximumParticipant, price: price, isPrivateRoom: isPrivateRoom, startTime: startTime, endTime: endTime, sex: sex, age: age, levelOfPlay: levelOfPlay, participant: participant, roomCode: roomCode)
        
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
                    defer {
                        self.objectWillChange.send()
                    }
//                    print("\(self.rooms)")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func createSurvey(name: String, birthDate: Date, sex: String, sportWith: String, favoriteSport: [String]){
        let record = CKRecord(recordType: RecordType.survey.rawValue)
        let survey = Survey(name: name, birthDate: birthDate, sex: sex, sportWith: sportWith, favoriteSport: favoriteSport)
        record.setValuesForKeys(survey.toDictionary())
        
        self.database.save(record){ returnedRecord, returnedError in
            print("Record: \(returnedRecord)")
            print("Error: \(returnedError)")
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
                            print(returnedSurveys)
                        case .failure(let error):
                            print(error)
                        }
                    }
                
                DispatchQueue.main.async {
                    self.surveys = returnedSurveys.map(SurveyViewModel.init)
                    print("31 \(self.surveys)")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }

}

