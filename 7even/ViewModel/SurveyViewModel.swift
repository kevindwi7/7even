//
//  SurveyViewModel.swift
//  7even
//
//  Created by Kevin  Dwi on 26/06/22.
//

import Foundation
import CloudKit

struct SurveyViewModel{
    let survey: Survey
    
    var id: CKRecord.ID? {
        survey.id
    }
    
    var name: String {
        survey.name
    }
    
    var birthDate: Date {
        survey.birthDate
    }
    
    var sex: String {
        survey.sex
    }
    
    var sportWith: String {
        survey.sportWith
    }
    
    var favoriteSport: [String]{
        survey.favoriteSport
    }
    
    var userID: String{
        survey.userID
    }
    
    var age: Int{
        survey.age
    }
}
