//
//  LevelOfPlay.swift
//  7even
//
//  Created by Inez Amanda on 23/06/22.
//

import Foundation

struct LevelOfPlay: Hashable, Identifiable {
    var id = UUID().uuidString
    var name: String
    var image:String
}

var level = [
    LevelOfPlay(name: "Recreational", image: "recreational"),
    LevelOfPlay(name: "Competitive", image: "recreational")
]
