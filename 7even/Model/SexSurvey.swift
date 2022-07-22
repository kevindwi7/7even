//
//  SexSurvey.swift
//  7even
//
//  Created by Kevin  Dwi on 22/07/22.
//

import Foundation

struct SexSurvey: Hashable, Identifiable {
    var id = UUID().uuidString
    var name: String
}

var sexesSurvey = [
    SexSurvey(name: "Female"),
    SexSurvey(name: "Male"),
]
