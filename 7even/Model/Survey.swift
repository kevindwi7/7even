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
    var favoriteSport: String
    
    init(id: CKRecord.ID? = nil, name: String, birthDate: Date, sex: String, sportWith: String, favoriteSport: String){
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
}


