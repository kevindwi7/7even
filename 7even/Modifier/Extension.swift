//
//  Extension.swift
//  7even
//
//  Created by Inez Amanda on 12/07/22.
//

import Foundation
import StreamChat

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

extension ChatClient {
    static var shared: ChatClient!
}
