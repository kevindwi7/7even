//
//  MapViewModel.swift
//  7even
//
//  Created by Kevin  Dwi on 14/07/22.
//

import Foundation
import SwiftUI
import MapKit

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    @Published var mapView = MKMapView()
    // Region..
    @Published var region : MKCoordinateRegion!
    // Based on location it will set up
    @Published var permissionDenied =  false
    
    @Published var mapType : MKMapType = .standard
    
    @Published var searchTxt = ""
    
    @Published var places: [Place] = []
    
    //updating map type
    func updateMapType(){
        if mapType == .standard{
            mapType = .hybrid
            mapView.mapType = mapType
        }else{
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    //focus location..
    func focusLocation(){
        guard let _ = region else{return}
        
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    //search Places...
    func searchQuery(){
        
        places.removeAll()
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTxt
        
        //Fetch
        MKLocalSearch(request: request).start { (responds, _) in
            guard let result = responds else{return}
            
            self.places = result.mapItems.compactMap({ (item) -> Place? in
                return Place(placemark: item.placemark)
            })
        }
    }
    
    //pick search result
    func selectedPlace(place: Place){
        searchTxt = ""
        
        guard let coordinate =  place.placemark.location?.coordinate else{return}
        
        let  pointAnnotation  = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.placemark.name ?? "No Name"
      
        self.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        // Removing All Old Ones
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pointAnnotation)
        
        //Moving map to that location
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func pinLocation(place: Place){
        guard let coordinate =  place.placemark.location?.coordinate else{return}
        
        let  pointAnnotation  = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
//        pointAnnotation.title = place.place.name ?? "No Name"
        pointAnnotation.title = place.placemark.title ?? "No Name"
        pointAnnotation.title = place.placemark.name ?? "No Name"
        pointAnnotation.title = place.placemark.countryCode ?? "No Name"
        // Removing All Old Ones
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pointAnnotation)
    }
//    func OnTapSelectedPlace(place: Place){
//        guard let coordinate =  place.placemark.location?.coordinate else{return}
//
//        let  pointAnnotation  = MKPointAnnotation()
//        pointAnnotation.coordinate = coordinate
//        pointAnnotation.title = place.placemark.name ?? "No Name"
//
//        // Removing All Old Ones
//        mapView.removeAnnotations(mapView.annotations)
//        mapView.addAnnotation(pointAnnotation)
//    }
//
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus{
        case .denied:
            //alert
            permissionDenied.toggle()
        case .notDetermined:
            //requesting
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            // if permission given
            manager.requestLocation()
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print(error.localizedDescription)
    }
    
    // Getting user region
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last else{return}
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 100000, longitudinalMeters: 100000)
        
        // updating map
        self.mapView.setRegion(self.region, animated: true)
        
        //smooth animation
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
        
        
        
    }
    
    func getAddressFromLatLon(Latitude: Double, Longitude: Double, completionHandler:@escaping(String)->Void) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        var addressString : String = ""

        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = Latitude
        center.longitude = Longitude

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]

                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.country)
                    print(pm.locality)
                    print(pm.subLocality)
                    print(pm.thoroughfare)
                    print(pm.postalCode)
                    print(pm.subThoroughfare)
                    
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }

                    completionHandler(addressString)

                    //print(addressString)
              }
        })

    }
    
    func getCityFromLatLon(Latitude: Double, Longitude: Double, completionHandler:@escaping(String)->Void) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        var cityString : String = ""

        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = Latitude
        center.longitude = Longitude

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]

                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.locality)
                   
                    
                    if pm.locality != nil {
                        cityString = cityString + pm.locality! + ", "
                    }

                    completionHandler(cityString)

                    //print(addressString)
              }
        })

    }
}
