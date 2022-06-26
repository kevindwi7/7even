//
//  Survey.swift
//  7even
//
//  Created by Kevin  Dwi on 23/06/22.
//

import Foundation
import CloudKit

struct Survey{
    let id: CKRecord.ID?
    var name: String
    var birthDate: Date
    var sex: String
    var sportWith: String
    var favoriteSport: [String]
    
    init(id: CKRecord.ID? = nil, name: String, birthDate: Date, sex: String, sportWith: String, favoriteSport: [String]){
        self.id = id
        self.name = name
        self.birthDate = birthDate
        self.sex = sex
        self.sportWith = sportWith
        self.favoriteSport = favoriteSport
    }
    
    func toDictionary() -> [String: Any]{
        return ["name": name, "birthDate": birthDate, "sex": sex, "sportWith": sportWith, "favoriteSport": favoriteSport]
    }
    
    static func fromRecord(_ record: CKRecord) -> Survey?{
        guard
              let name = record.value(forKey: "name") as? String,
              let birthDate = record.value(forKey: "birthDate") as? Date,
              let sex = record.value(forKey: "sex") as? String,
              let sportWith = record.value(forKey: "sportWith") as? String,
              let favoriteSport = record.value(forKey: "favoriteSport") as? [String]
             
        else {
            print("Tes")
            return nil
        }
//        print(levelOfPlay)
        
        return Survey(id: record.recordID, name: name, birthDate: birthDate, sex: sex, sportWith: sportWith, favoriteSport: favoriteSport)
    }
}


