//
//  Place.swift
//  7even
//
//  Created by Kevin  Dwi on 14/07/22.
//

import Foundation
import MapKit

struct Place: Identifiable{
    let placemark: MKPlacemark
    
//    var id = UUID().uuidString
    var id: UUID {
        return UUID()
    }
    
    var name: String{
        self.placemark.name ?? ""
    }
    
    var title: String{
        self.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D{
        self.placemark.coordinate
    }
    
    var latitude: Double{
        self.placemark.coordinate.latitude
    }
    
    var longtitude: Double{
        self.placemark.coordinate.longitude
    }
    
//    var place: CLPlacemark
}
