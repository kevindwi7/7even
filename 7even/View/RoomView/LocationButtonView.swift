//
//  ButtonModalView.swift
//  7even
//
//  Created by Inez Amanda on 21/06/22.
//

import SwiftUI
import CoreLocation
import MapKit

struct LocationButtonView: View {
    
    var showModalButton = false
    var showIcon = false
    var iconName = "mappin"
    var type = ""

    @Binding var textLabel: String
    @State var isPresented = false
//    @Binding var place: Place
    @Binding var region: String
    @Binding var location: String
    @Binding var address: String
    @StateObject var mapData = MapViewModel()
    @State var locationManager = CLLocationManager()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color(UIColor.systemGray5))
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.systemBackground)))
            VStack(alignment: .leading, spacing: 8) {
                if showIcon {
                    Button(action: {
                        self.isPresented.toggle()
                    }) {
                        //
                        //
                        HStack{
                            Image(systemName: iconName)
                                .font(.body)
                            if(textLabel == "") {
                                Text("Choose Location")
                                    .foregroundColor(Color.primary)
                            } else {
                                Text(textLabel)
                                    .foregroundColor(Color.primary)
                            }
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                        
                        
                    }.sheet(
                        isPresented: $isPresented
                    ) {
                        print("The sheet has been dismissed")
//                        print(location)
                    } content: {
                        NavigationView{
                            ZStack{
                                MapView()
                                    .environmentObject(mapData)
                                    .ignoresSafeArea(edges: .bottom)
//                                    .onTapGesture { test in
//                                        print("Tapped at \(test)" )
//                                    }
                                //                                    .onTapGesture {
//                                        ForEach(mapData.places){ place in
//
//                                        mapData.OnTapSelectedPlace(place: place)
//
//                                        }
//                                    }
                                VStack{
                                    VStack(spacing: 0){
                                        HStack{
                                            Image(systemName: "magnifyingglass")
                                                .foregroundColor(.gray)
                                            
                                            TextField("Search", text: $mapData.searchTxt)
                                        }
                                        .padding(.vertical, 10)
                                        .padding(.horizontal)
                                        .background(Color.white)
                                        
                                        //Displaying results..
                                        
                                        if !mapData.places.isEmpty && mapData.searchTxt != ""{
                                            ScrollView{
                                                VStack(spacing: 15){
                                                    ForEach(mapData.places) { place in
                                                        Text(place.placemark.name ?? "")
                                                            .foregroundColor(.black)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                            .padding(.leading)
                                                            .onTapGesture {
                                                                mapData.selectedPlace(place: place)
                                                                location = place.placemark.name ?? ""
                                                                
                                                                
                                                                mapData.getAddressFromLatLon(Latitude: place.placemark.coordinate.latitude, Longitude: place.placemark.coordinate.longitude) { dataProcess in
                                                                    address = dataProcess
                                                                    print("address", address)
                                                                    
                                                                    mapData.getCityFromLatLon(Latitude: place.placemark.coordinate.latitude, Longitude: place.placemark.coordinate.longitude){
                                                                        cityProcess in
                                                                        region = cityProcess
                                                                        print(region)
                                                                    }
                                                                }
                                                                
                                                                
                                                                
                                                                
                                                                
                                                            }
                                                        
                                                        Divider()
                                                          
                                                    }
                                                }
                                                .padding(.top)
                                            }
                                            .background(Color.white)
                                        }
                                        
                                    }
                                    .padding()
                                   
                                    
                                    Spacer()
                                    
                                    VStack{
                                        Button(action: {mapData.focusLocation()}, label: {
                                            Image(systemName: "location.fill")
                                                .font(.title)
                                                .padding(10)
                                                .background(Color.primary)
                                                .clipShape(Circle())
                                        })
                                        
                                        Button(action: {mapData.updateMapType()}, label: {
                                            Image(systemName: mapData.mapType == .standard ? "network" : "map")
                                                .font(.title)
                                                .padding(10)
                                                .background(Color.primary)
                                                .clipShape(Circle())
                                        })
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding()
                                }
                            }
//                            .searchable(text: $mapData.searchTxt, placement: .navigationBarDrawer(displayMode: .always),prompt: "Search" )
                            .navigationBarTitle(Text("Choose Location"), displayMode: .inline)
//                            .toolbar{
//                                Button(action: {
//                                  
//                                 
//                                }, label: {
//                                    Text("Submit")
//                                })
//                            }
                            .navigationBarItems(leading: Button(action: {
                                    print("The sheet has been dismissed")
                                    self.isPresented = false
                            }) {
                                Image(systemName: "chevron.left")
                                .font(.body)
                            })
                            .onAppear(perform: {
                                locationManager.delegate = mapData
                                locationManager.requestWhenInUseAuthorization()
                            })
                        }
                        
                       //permission denied alert
                        .alert(isPresented: $mapData.permissionDenied, content: {
                            Alert(title: Text("Permission Denied"), message: Text("Please Enable Permission In App Settings"), dismissButton: .default(Text("Go To Settings"), action: {
                                //Redirecting user to setting
                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                            }))
                        })
                        .onChange(of: mapData.searchTxt, perform: { value in
                            let delay = 0.3
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + delay){
                                if value == mapData.searchTxt{
                                    self.mapData.searchQuery()
                                }
                            }
                        })
                    }
                }
            }.padding(5)
        }
        //        .cornerRadius(12)
        .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
        .fixedSize(horizontal: false, vertical: true)
        //        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
    }
}

