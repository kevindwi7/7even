//
//  SportWith.swift
//  7even
//
//  Created by Kevin  Dwi on 28/06/22.
//

import Foundation

struct SportWith: Hashable, Identifiable {
    var id = UUID().uuidString
    var name: String
}

var sportsWith = [
    SportWith(name: "Partner"),
    SportWith(name: "Stranger"),
    SportWith(name: "Everyone")
]
