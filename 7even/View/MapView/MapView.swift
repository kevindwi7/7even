//
//  MapView.swift
//  7even
//
//  Created by Kevin  Dwi on 14/07/22.
//

import Foundation
import MapKit
import SwiftUI

struct MapView: UIViewRepresentable{
    
    @EnvironmentObject var mapData: MapViewModel
    
    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView{
        let view = mapData.mapView
        let tap = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.doubleTapped))
        tap.numberOfTapsRequired = (2)
        
        view.addGestureRecognizer(tap)
        
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ map: MKMapView, context: Context) {
        map.removeAnnotations(map.annotations)
        map.addAnnotations(map.annotations)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate{
        @objc func doubleTapped(){
            
        }
    }
}
