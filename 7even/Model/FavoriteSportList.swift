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
    var isCheck: Bool
}

var sports = [
    Sport(name: "Badminton", image: "badminton", isCheck: false),
    Sport(name: "Basketball",image: "basketball", isCheck: false),
//    Sport(name: "Tennis", image: "tennis", isCheck: false),
    Sport(name: "Football",image: "soccer", isCheck: false),
    Sport(name: "Running", image: "running", isCheck: false),
]
