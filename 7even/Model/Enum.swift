//
//  Enum.swift
//  7even
//
//  Created by Inez Amanda on 22/06/22.
//

import Foundation

enum REGION: String, CaseIterable, Identifiable {
    var id: Self {self}
    case sbyBarat = "Surabaya Barat"
    case sbyPusat = "Surabaya Pusat"
    case sbySelatan = "Surabaya Selatan"
    case sbyTimur = "Surabaya Timur"
    case sbyUtara = "Surabaya Utara"
}


//enum PREFERENCETYPE: String, CaseIterable, Identifiable {
//    var id: PREFERENCETYPE { self }
//
//    static func getPreferenceFromType(type: String) -> [PREFERENCETYPE] {
//        switch type {
//            case "region":
//                return PREFERENCETYPE.region
//            default:
//                return PREFERENCETYPE.region
//        }
//    }
//
//    
//    case sbyBarat = "Surabaya Barat"
//    case sbyPusat = "Surabaya Pusat"
//    case sbySelatan = "Surabaya Selatan"
//    case sbyTimur = "Surabaya Timur"
//    case sbyUtara = "Surabaya Utara"
//
//    static let region: [PREFERENCETYPE] = [.sbyBarat, .sbyPusat, .sbySelatan, .sbyTimur, .sbyUtara]
//}
