//
//  Location.swift
//  7even
//
//  Created by Inez Amanda on 22/06/22.
//

import Foundation

struct Location: Hashable {
    var name: String
    var address: String
    
    internal init(name: String, address: String) {
        self.name = name
        self.address = address
    }
}

extension Location {
    static var locationList = [
        Location(name: "Lapangan ABC", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia"),
        Location(name: "Lapangan DEF", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia"),
        Location(name: "Lapangan GHI", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia"),
        Location(name: "Lapangan JKL", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia"),
        Location(name: "Lapangan MNO", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia"),
        Location(name: "Lapangan PQR", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia"),
        Location(name: "Lapangan STU", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia"),
        Location(name: "Lapangan VWX", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia"),
        Location(name: "Lapangan YZ", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia")
    ]
}
