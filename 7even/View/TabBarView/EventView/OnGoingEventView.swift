//
//  OnGoingEventView.swift
//  7even
//
//  Created by Kevin  Dwi on 12/07/22.
//

import SwiftUI

struct OnGoingEventView: View {
    @StateObject var vm: MainViewModel
    @State var userID = UserDefaults.standard.object(forKey: "userID") as? String
    
    @Binding var room: RoomViewModel
    
    let defaults = UserDefaults.standard
    
    var startTime: String{
        let calender = Calendar.current
        let day = calender.component(.day, from: room.startTime)
        let month = calender.component(.month, from: room.startTime)
        let year = calender.component(.year, from: room.startTime)
        let hour = calender.component(.hour, from: room.startTime)
        let minutes = calender.component(.minute, from: room.startTime)
        let seconds = calender.component(.second, from: room.startTime)
        
        let theDate = "\(day)/\(month)/\(year), \(hour):\(minutes)"
        
        return theDate
    }
    
    var endTime: String{
        let calender = Calendar.current
        let day = calender.component(.day, from: room.endTime)
        let month = calender.component(.month, from: room.endTime)
        let year = calender.component(.year, from: room.endTime)
        let hour = calender.component(.hour, from: room.endTime)
        let minutes = calender.component(.minute, from: room.endTime)
        let seconds = calender.component(.second, from: room.endTime)
        
        let theDate = "\(day)/\(month)/\(year), \(hour):\(minutes)"
        
        return theDate
    }
    var currentTime: String{
        let calender = Calendar.current
        let day = calender.component(.day, from: Date())
        let month = calender.component(.month, from: Date())
        let year = calender.component(.year, from: Date())
        let hour = calender.component(.hour, from: Date())
        let minutes = calender.component(.minute, from: Date())
        let seconds = calender.component(.second, from: Date())
        
        let theDate = "\(day)/\(month)/\(year), \(hour):\(minutes)"
        
        return theDate
    }
    
    
    private let roomAdaptiveColumns = [
        GridItem(.adaptive(minimum: 280)),
        GridItem(.adaptive(minimum: 280))
    ]
    
    
    var body: some View {
        VStack{
                ForEach($vm.surveys, id: \.id){ $item in
                    if(item.userID == self.userID && currentTime < startTime && room.isFinish == false){
                       
                        ListRoomCardView(vm: self.vm, room: $room)
                        
                    }
                
                }
            
          
        }
    }
}
