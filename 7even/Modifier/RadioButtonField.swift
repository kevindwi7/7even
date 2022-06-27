//
//  RadioButtonField.swift
//  7even
//
//  Created by Inez Amanda on 27/06/22.
//

import SwiftUI

struct RadioButtonField: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let bgColor: Color
    let isMarked:Bool
    let callback: (String)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 15,
        color: Color = Color.black,
        bgColor: Color = Color.black,
        isMarked: Bool = false,
        callback: @escaping (String)->()
        ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.bgColor = bgColor
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center) {
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                    .clipShape(Circle())
                    .foregroundColor(self.bgColor)
                Text(label)
                    .font(.callout)
                Spacer()
            }.foregroundColor(self.color)
//            .background(Color.red)
            
        }
        .foregroundColor(Color.white)
    }
}

