//
//  Enum.swift
//  7even
//
//  Created by Inez Amanda on 22/06/22.
//

import Foundation

enum PREFERENCETYPE: String, CaseIterable, Identifiable {
    var id: PREFERENCETYPE { self }

    static func getPreferenceFromType(type: String) -> [PREFERENCETYPE] {
        switch type {
            case "sport":
                return PREFERENCETYPE.sport
            case "sex":
                return PREFERENCETYPE.sex
            case "age":
                return PREFERENCETYPE.age
            case "levelOfPlay":
                return PREFERENCETYPE.levelOfPlay
            default:
                return PREFERENCETYPE.sport
        }
    }
    
    case tennis = "Tennis"
    case badminton = "Badminton"
    case yoga = "Yoga"
    case basketball = "Basketball"
    
    case first = "18-20"
    case second = "20-25"
    case third = "25-30"
    case fourth = "35-40"
    
    case male = "Male Only"
    case female = "Female Only"
    
    case recreational = "Recreational"
    case competitive = "Competitive"
    
    static let sport: [PREFERENCETYPE] = [.tennis, .badminton, .yoga, .basketball]
    static let sex: [PREFERENCETYPE] = [.male, .female]
    static let age: [PREFERENCETYPE] = [.first, .second, .third, .fourth]
    static let levelOfPlay: [PREFERENCETYPE] = [.recreational, .competitive]
}
