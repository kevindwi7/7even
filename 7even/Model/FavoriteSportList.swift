//
//  FavoriteSportList.swift
//  7even
//
//  Created by Kevin  Dwi on 23/06/22.
//

import Foundation

struct Sport: Identifiable, Hashable {
    var id = UUID().uuidString
    var name: String
    var image:String
    var isCheckes: Bool
}

var sports = [
    Sport(name: "Badminton", image: "badminton", isCheckes: false),
    Sport(name: "Basketball",image: "basketball", isCheckes: false),
    Sport(name: "Tennis", image: "tennis", isCheckes: false),
    Sport(name: "Futsal",image: "soccer", isCheckes: false),
    Sport(name: "Volleyball", image: "volleyball", isCheckes: false),
]
