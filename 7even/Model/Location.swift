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
    var region: String
    
    internal init(name: String, address: String, region: String) {
        self.name = name
        self.address = address
        self.region = region
    }
}

extension Location {
    static var locationList = [
        Location(name: "Lapangan ABC", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia", region: "Surabaya Barat"),
        Location(name: "Lapangan DEF", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia", region: "Surabaya Utara"),
        Location(name: "Lapangan GHI", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia", region: "Surabaya Selatan"),
        Location(name: "Lapangan JKL", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia", region: "Surabaya Pusat"),
        Location(name: "Lapangan MNO", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia", region: "Surabaya Timur"),
        Location(name: "Lapangan PQR", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia", region: "Surabaya Barat"),
        Location(name: "Lapangan STU", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia", region: "Surabaya Utara"),
        Location(name: "Lapangan VWX", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia", region: "Surabaya Timur"),
        Location(name: "Lapangan YZ", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia", region: "Surabaya Pusat")
    ]
}
