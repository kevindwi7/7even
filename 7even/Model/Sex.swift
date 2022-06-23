//
//  Sex.swift
//  7even
//
//  Created by Inez Amanda on 23/06/22.
//

import Foundation

struct Sex: Hashable, Identifiable {
    var id = UUID().uuidString
    var name: String
    var image:String
}

var sexes = [
    Sex(name: "Male", image: "male"),
    Sex(name: "Female", image: "female")
]

