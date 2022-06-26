//
//  ProfileView.swift
//  7even
//
//  Created by Kevin  Dwi on 24/06/22.
//

import SwiftUI
import CloudKit

struct ProfileView: View {
    @State private var isShowing = false
    @StateObject private var vm: MainViewModel
    @State var action: Int? = 0
    
    let defaults = UserDefaults.standard
    
    init(vm: MainViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        //        NavigationView{
        VStack{
            ForEach(vm.surveys, id: \.id){surveys in
                if(!defaults.bool(forKey: "login")){
                    LazyVStack{
                        Text("Sign up to manage your preferences")
                        NavigationLink(destination: LoginView(), label: {
                            Text("Here")
                                .bold()
                                .foregroundColor(.mint)
                                .underline()
                        })
                    }.padding(.vertical, 25)
                    
                }else{
                    HStack{
                        Image("apple").resizable().scaledToFit().frame(height:100).padding()
                        VStack{
                            HStack{
                                //                        NavigationLink(destination: EditProfileView(), tag: 1, selection: $action){
                                //                            EmptyView()
                                //
                                //                        }
                                
                                Text(surveys.name)
                                Spacer()
                                Button(action: {
                                    self.action = 1
                                }){
                                    Text("Edit")
                                        .padding(.horizontal)
                                        .padding(.vertical, 5)
                                        .background(.mint)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                
                                
                            }
                            if let email = UserDefaults.standard.object(forKey: "email") as? String {
                                HStack{
                                    Text(email)
                                    Spacer()
                                }
                            }
                            
                            HStack{
                                Image("star").resizable().scaledToFit().frame(height:20)
                                Text("4.8")
                                Spacer()
                            }
                        }
                        
                        
                        
                    }.listRowSeparator(.hidden)
                    
                    VStack{
                        HStack{
                            Text("Hosted Event")
                            Spacer()
                            Text("10")
                        }.padding(.horizontal,50)
                            .padding()
                        HStack{
                            Text("Attended Event")
                            Spacer()
                            Text("5")
                        }.padding(.horizontal,50)
                            .padding()
                        HStack{
                            Text("Partners")
                            Spacer()
                            Text("10")
                        }.padding(.horizontal,50)
                            .padding()
                        HStack{
                            Text("Preferred Sport")
                            Spacer()
                            Button(action: {}){
                                Image(systemName: "plus").foregroundColor(.mint)
                            }
                            
                        }
                        .padding(.horizontal,50)
                        .padding()
                        HStack{
                            ForEach(surveys.favoriteSport, id: \.self){ sport in
                                Text(sport)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(width: 120, height: 60)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.mint).shadow( radius: 3))
                                    .foregroundColor(.white)
                                //                        ZStack{
                                //                            RoundedRectangle(cornerRadius: 10)
                                //                                .fill(.white)
                                //                                .shadow(radius: 5)
                                //                            VStack{
                                //                                HStack{
                                //                                    Text(sport)
                                //                                        .foregroundColor(.black)
                                //                                    Spacer()
                                //                                }
                                //
                                //                            }
                                //                        }.padding()
                                
                            }
                        }.padding()
                        
                        
                    }
                }
                
                
                
            }
            .padding()
            Spacer()
        }.onAppear{
            vm.fetchSurvey()
        }
        //        }.navigationBarHidden(true)
        
        
        //        VStack{
        //            ForEach(vm.surveys, id: \.id){ surveys in
        //
        //                .padding(.vertical, 50)
        //                Spacer()
        //
        //            }
        //
        //
        //        } .onAppear {
        //            vm.fetchSurvey()
    }
}




//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}

