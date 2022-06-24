//
//  ProfileView.swift
//  7even
//
//  Created by Kevin  Dwi on 24/06/22.
//

import SwiftUI

struct ProfileView: View {
    let lightGreyColor = Color(red: 0, green: 199, blue: 190)
    @State private var isShowing = false
    var body: some View {
        VStack{
            HStack{
                Image("apple").resizable().scaledToFit().frame(height:100).padding()
                VStack{
                    HStack{
                        Text("Dwi Wijaya")
                        Spacer()
                        Text("Edit")
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(lightGreyColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .onTapGesture {
                                print("edit tapped")
                            }
                        
                        
                        
                    }
                    HStack{
                        Text("dwiwijaya@gmail.com")
                        Spacer()
                    }
                    
                    HStack{
                        Image("star").resizable().scaledToFit().frame(height:20)
                        Text("test")
                        Spacer()
                    }
                }
                
                .padding()
                
            }
            
            VStack{
                HStack{
                    Text("Hosted Event")
                    Spacer()
                    Text("19")
                }.padding(.horizontal,50)
                    .padding()
                HStack{
                    Text("Attended Event")
                    Spacer()
                    Text("19")
                }.padding(.horizontal,50)
                    .padding()
                HStack{
                    Text("Partners")
                    Spacer()
                    Text("19")
                }.padding(.horizontal,50)
                    .padding()
                HStack{
                    Text("Preferred Sport")
                    Spacer()
                    Text("19")
                }.padding(.horizontal,50)
                    .padding()
            }
            .padding(.vertical, 50)
            Spacer()
        }
        //        NavigationView{
        //            Text("SignUp")
        //                 .onTapGesture {
        //                     isShowing = true
        //                 }
        //        }
        //        .sheet(isPresented: $isShowing, content: {
        //            LoginView()
        //        })
        //
        
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
