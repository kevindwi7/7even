//
//  Enum.swift
//  7even
//
//  Created by Inez Amanda on 22/06/22.
//

import Foundation

enum PREFERENCETYPE: String {
    case sport = "sport"
    case sex = "sex"
    case age = "age"
    case level = "level"
}

enum SPORT: String, CaseIterable {
    case tennis = "Tennis"
    case badminton = "Badminton"
    case yoga = "Yoga"
    case basketball = "Basketball"
}

enum AGE: String, CaseIterable {
    case first = "18-20"
    case second = "20-25"
    case third = "25-30"
    case fourth = "35-40"
}

enum SEX: String, CaseIterable {
    case male = "Male Only"
    case female = "Female Only"
}

enum LEVEL: String, CaseIterable {
    case recreational = "Recreational"
    case competitive = "Competitive"
}
