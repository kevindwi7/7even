//
//  Age.swift
//  7even
//
//  Created by Inez Amanda on 23/06/22.
//

import Foundation

struct Age: Hashable, Identifiable {
    var id = UUID().uuidString
    var name: String
    var image:String
}

var ages = [
    Age(name: "18-25", image: "18-25"),
    Age(name: "25-35", image: "25-35"),
    Age(name: "35-45", image: "35-45"),
    Age(name: "45-55", image: "45-55")
]
