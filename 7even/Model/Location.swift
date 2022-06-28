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
    var isChecked: Bool
    
    init(name: String, address: String, region: String, isChecked: Bool) {
        self.name = name
        self.address = address
        self.region = region
        self.isChecked = isChecked
    }
}

var locationList = [
    Location(name: "Lapangan ABC", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia", region: "Surabaya Barat", isChecked: false),
    Location(name: "Lapangan DEF", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia", region: "Surabaya Utara", isChecked: false),
    Location(name: "Lapangan GHI", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia", region: "Surabaya Selatan", isChecked: false),
    Location(name: "Lapangan JKL", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia", region: "Surabaya Pusat", isChecked: false),
    Location(name: "Lapangan MNO", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia", region: "Surabaya Timur", isChecked: false),
    Location(name: "Lapangan PQR", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia", region: "Surabaya Barat", isChecked: false),
    Location(name: "Lapangan STU", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia", region: "Surabaya Utara", isChecked: false),
    Location(name: "Lapangan VWX", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia", region: "Surabaya Timur", isChecked: false),
    Location(name: "Lapangan YZ", address: "Citraland CBD Boulevard, Made, Kec. Sambikerep, Kota SBY, Jawa Timur 60219, Indonesia", region: "Surabaya Pusat", isChecked: false)
]
