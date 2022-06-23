//
//  FavoriteSportList.swift
//  7even
//
//  Created by Kevin  Dwi on 23/06/22.
//

import Foundation

struct Sport: Identifiable {
    var id = UUID().uuidString
    var name: String
    var image:String
}

var sports = [
    Sport(name: "Badminton", image: "badminton"),
    Sport(name: "Basketball",image: "basketball"),
    Sport(name: "Tennis", image: "tennis"),
    Sport(name: "Futsal",image: "soccer"),
    Sport(name: "Volleyball", image: "volleyball"),
]
