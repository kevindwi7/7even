//
//  ProfileView.swift
//  7even
//
//  Created by Kevin  Dwi on 24/06/22.
//

import SwiftUI
import CloudKit

struct ProfileView: View {
    @State var isShowing = false
    @StateObject private var vm: MainViewModel
    @State var action: Int? = 0
    @State var isContentView = false
    
    let defaults = UserDefaults.standard
    let email = UserDefaults.standard.object(forKey: "email") as? String
    
    init(vm: MainViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading){
                    if(!defaults.bool(forKey: "login")){
                        LazyVStack{
                            Text("Sign up to manage your preferences")
                            NavigationLink(destination: LoginView(toMainPage: $isContentView),isActive: $isContentView){
                                EmptyView()
                                //
                            }
                            Button("Here"){
                                isContentView = true
                            }
                        }.padding(.vertical, 25)
                    }else{
                        ForEach(vm.surveys, id: \.id){ surveys in
                            VStack{
                                Button("test"){
                                    print(surveys.name)
                                }
                            }
                        }
                            ZStack{
                                Rectangle().fill(.white)
                                HStack{
                                    Image(systemName: "person.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.mint)
                                        .frame(height:80).padding()
                                    VStack{
                                        HStack{
                                            Text("Dwi Wijaya").font(.system(size: 24, weight: .bold))
                                            Spacer()
                                            
                                        }
                                        
                                        HStack{
                                            Image("star").resizable().scaledToFit().frame(height:20)
                                            Text("4.8")
                                            Spacer()
                                        }
                                        
                                        
                                    }
                                    
                                    
                                    
                                }.padding()
                            }.padding(.vertical,1)
                            
                            ZStack{
                                Rectangle().fill(.white)
                                VStack{
                                    HStack{
                                        Text("Info Profile").font(.system(size: 14,weight: .bold))
                                        Spacer()
                                    }
                                    .padding(.horizontal, 24)
                                    .padding(.vertical,12)
                                    
                                    HStack{
                                        Text("Age").font(.system(size: 16))
                                        Spacer()
                                        Text("29 Tahun").font(.system(size: 16))
                                        Spacer()
                                    }
                                    .padding(.horizontal, 24)
                                    
                                    HStack{
                                        Text("Gender").font(.system(size: 16)).multilineTextAlignment(.center)
                                        Spacer()
                                        Text("Female").font(.system(size: 16)).multilineTextAlignment(.center)
                                        Spacer()
                                    }
                                    .padding(.horizontal, 24)
                                    .padding(.vertical,12)
                                    
                                    HStack{
                                        Text("Preferred Partner").font(.system(size: 16))
                                        Spacer()
                                        
                                    }
                                    .padding(.horizontal, 24)
                                    .padding(.vertical,5)
                                    
                                    HStack{
                                        Text("Sport With Anyone")
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: 14,weight: .bold))
                                            .frame(width: 120, height: 60)
                                            .background(RoundedRectangle(cornerRadius: 12).stroke(.mint, lineWidth: 1).shadow(radius: 2))
                                            .foregroundColor(.black)
                                        Spacer()
                                    }
                                    .padding(.horizontal, 24)
                                    .padding(.vertical,12)
                                    
                                    HStack{
                                        Text("Preferred Sports").font(.system(size: 16))
                                        Spacer()
                                        NavigationLink(destination: EditProfileView(toMainPage: $isContentView), isActive: $isContentView){
                                            EmptyView()
                                            //
                                        }
                                        Button(action: {
                                            isContentView = true
                                        }){
                                            Image(systemName: "plus").resizable().scaledToFit().frame(height: 18).foregroundColor(.mint)
                                        }

                                    }
                                    .padding(.horizontal, 24)
                                    .padding(.vertical,5)
                                    
                                    HStack{
                                        Text("Badminton")
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: 14,weight: .bold))
                                            .frame(width: 120, height: 60)
                                            .background(RoundedRectangle(cornerRadius: 12).stroke(.mint, lineWidth: 1).shadow(radius: 2))
                                            .foregroundColor(.black)
                                        
                                        Text("Futsal")
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: 14,weight: .bold))
                                            .frame(width: 120, height: 60)
                                            .background(RoundedRectangle(cornerRadius: 12).stroke(.mint, lineWidth: 1).shadow(radius: 2))
                                            .foregroundColor(.black)
                                        Spacer()
                                    }
                                    .padding(.horizontal, 24)
                                    .padding(.vertical,12)
                                }
                                
                            }.padding(.vertical,12)
                            
                            ZStack{
                                Rectangle().fill(.white)
                                VStack{
                                    HStack{
                                        Text("Info Events").font(.system(size: 14,weight: .bold))
                                        Spacer()
                                    }
                                    .padding(.horizontal, 24)
                                    .padding(.vertical,12)
                                    
                                    HStack{
                                        Text("Hosted").font(.system(size: 16))
                                        Spacer()
                                        Text("19 Times").font(.system(size: 16))
                                        Spacer()
                                    }
                                    .padding(.horizontal, 24)
                                    
                                    
                                    HStack{
                                        Text("Attended").font(.system(size: 16))
                                        Spacer()
                                        Text("28 Times").font(.system(size: 16))
                                        Spacer()
                                    }
                                    .padding(.horizontal, 24)
                                    .padding(.vertical,12)
                                }
                            }
                        
                        //                        ForEach(vm.surveys, id: \.id){ surveys in
                        //                            if(surveys.email == email){
                        //                                ZStack{
                        //                                    Rectangle().fill(.white)
                        //                                    HStack{
                        //                                        Image(systemName: "person.circle")
                        //                                            .resizable()
                        //                                            .scaledToFit()
                        //                                            .foregroundColor(.mint)
                        //                                            .frame(height:80).padding()
                        //                                        VStack{
                        //                                            HStack{
                        //                                                Text(surveys.name).font(.system(size: 24, weight: .bold))
                        //                                                Spacer()
                        //
                        //                                            }
                        //
                        //                                            HStack{
                        //                                                Image("star").resizable().scaledToFit().frame(height:20)
                        //                                                Text("4.8")
                        //                                                Spacer()
                        //                                            }
                        //
                        //
                        //                                        }
                        //
                        //
                        //
                        //                                    }.padding()
                        //                                }.padding(.vertical,1)
                        //
                        //                                ZStack{
                        //                                    Rectangle().fill(.white)
                        //                                    VStack{
                        //                                        HStack{
                        //                                            Text("Info Profile").font(.system(size: 14,weight: .bold))
                        //                                            Spacer()
                        //                                        }
                        //                                        .padding(.horizontal, 24)
                        //                                        .padding(.vertical,12)
                        //
                        //                                        HStack{
                        //                                            Text("Age").font(.system(size: 16))
                        //                                            Spacer()
                        //                                            Text("29 Tahun").font(.system(size: 16))
                        //                                            Spacer()
                        //                                        }
                        //                                        .padding(.horizontal, 24)
                        //
                        //                                        HStack{
                        //                                            Text("Gender").font(.system(size: 16)).multilineTextAlignment(.center)
                        //                                            Spacer()
                        //                                            Text("Female").font(.system(size: 16)).multilineTextAlignment(.center)
                        //                                            Spacer()
                        //                                        }
                        //                                        .padding(.horizontal, 24)
                        //                                        .padding(.vertical,12)
                        //
                        //                                        HStack{
                        //                                            Text("Preferred Partner").font(.system(size: 16))
                        //                                            Spacer()
                        //
                        //                                        }
                        //                                        .padding(.horizontal, 24)
                        //                                        .padding(.vertical,5)
                        //
                        //                                        HStack{
                        //                                            Text("Sport With Anyone")
                        //                                                .multilineTextAlignment(.center)
                        //                                                .font(.system(size: 14,weight: .bold))
                        //                                                .frame(width: 120, height: 60)
                        //                                                .background(RoundedRectangle(cornerRadius: 12).stroke(.mint, lineWidth: 1).shadow(radius: 2))
                        //                                                .foregroundColor(.black)
                        //                                            Spacer()
                        //                                        }
                        //                                        .padding(.horizontal, 24)
                        //                                        .padding(.vertical,12)
                        //
                        //                                        HStack{
                        //                                            Text("Preferred Sports").font(.system(size: 16))
                        //                                            Spacer()
                        //                                            Image(systemName: "plus").resizable().scaledToFit().frame(height: 18).foregroundColor(.mint)
                        //                                        }
                        //                                        .padding(.horizontal, 24)
                        //                                        .padding(.vertical,5)
                        //
                        //                                        HStack{
                        //                                            Text("Badminton")
                        //                                                .multilineTextAlignment(.center)
                        //                                                .font(.system(size: 14,weight: .bold))
                        //                                                .frame(width: 120, height: 60)
                        //                                                .background(RoundedRectangle(cornerRadius: 12).stroke(.mint, lineWidth: 1).shadow(radius: 2))
                        //                                                .foregroundColor(.black)
                        //
                        //                                            Text("Futsal")
                        //                                                .multilineTextAlignment(.center)
                        //                                                .font(.system(size: 14,weight: .bold))
                        //                                                .frame(width: 120, height: 60)
                        //                                                .background(RoundedRectangle(cornerRadius: 12).stroke(.mint, lineWidth: 1).shadow(radius: 2))
                        //                                                .foregroundColor(.black)
                        //                                            Spacer()
                        //                                        }
                        //                                        .padding(.horizontal, 24)
                        //                                        .padding(.vertical,12)
                        //                                    }
                        //
                        //                                }.padding(.vertical,12)
                        //
                        //                                ZStack{
                        //                                    Rectangle().fill(.white)
                        //                                    VStack{
                        //                                        HStack{
                        //                                            Text("Info Events").font(.system(size: 14,weight: .bold))
                        //                                            Spacer()
                        //                                        }
                        //                                        .padding(.horizontal, 24)
                        //                                        .padding(.vertical,12)
                        //
                        //                                        HStack{
                        //                                            Text("Hosted").font(.system(size: 16))
                        //                                            Spacer()
                        //                                            Text("19 Times").font(.system(size: 16))
                        //                                            Spacer()
                        //                                        }
                        //                                        .padding(.horizontal, 24)
                        //
                        //
                        //                                        HStack{
                        //                                            Text("Attended").font(.system(size: 16))
                        //                                            Spacer()
                        //                                            Text("28 Times").font(.system(size: 16))
                        //                                            Spacer()
                        //                                        }
                        //                                        .padding(.horizontal, 24)
                        //                                        .padding(.vertical,12)
                        //                                    }
                        //                                }
                        //                            }
                        //                        }
                        //                        LazyVStack(alignment: .leading) {
                        //                            Text("Profile").bold()
                        //                        }
                        //                        .font(.title)
                        //                        .padding(EdgeInsets(top: -94, leading: 16, bottom: 20, trailing: 0))
                        
                    }
                    
                    Spacer()
                }
            }
        }.navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

//            .onAppear{
//                vm.fetchSurvey()
//            }

//
//                        VStack{
//                            HStack{
//                                Text("Hosted Event")
//                                Spacer()
//                                Text("10")
//                            }.padding(.horizontal,50)
//                                .padding()
//                            HStack{
//                                Text("Attended Event")
//                                Spacer()
//                                Text("5")
//                            }.padding(.horizontal,50)
//                                .padding()
//                            HStack{
//                                Text("Partners")
//                                Spacer()
//                                Text("10")
//                            }.padding(.horizontal,50)
//                                .padding()
//                            HStack{
//                                Text("Preferred Sport")
//                                Spacer()
//                                Button(action: {}){
//                                    Image(systemName: "plus").foregroundColor(.mint)
//                                }
//
//                            }
//                            .padding(.horizontal,50)
//                            .padding()
//                            HStack{
//                                ForEach(surveys.favoriteSport, id: \.self){ sport in
//                                    Text(sport)
//                                        .multilineTextAlignment(.center)
//                                        .padding()
//                                        .frame(width: 120, height: 60)
//                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.mint).shadow( radius: 3))
//                                        .foregroundColor(.white)
//
//
//                                }
//                            }.padding()
//
//
//                        }
//                    }
//                    ForEach(vm.surveys, id: \.id){ surveys in
//                        if(surveys.email == email){
//                            Text(surveys.name)
//                        }
//                    }

//                ForEach(vm.surveys, id: \.id){ surveys in
//                    if(!defaults.bool(forKey: "login")){
//                        LazyVStack{
//                            Text("Sign up to manage your preferences")
//                            NavigationLink(destination: LoginView(toMainPage: $isContentView),isActive: $isContentView){
//                                EmptyView()
//                                Text("Here")
//                                    .bold()
//                                    .foregroundColor(.mint)
//                                    .underline()
//                            }
//
//                            Button("Here"){
//                                isContentView = true
//                            }
//                        }.padding(.vertical, 25)
//                    }else{
//                        if(surveys.email == email){
//                            Text(surveys.name)
//                        }
//                    }
//
//                }

//        }.navigationTitle("Profile")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar{
//                NavigationLink(destination: EditProfileView()){
//                    Text("Edit")
//
//                }
//            }
//        NavigationView{
//            VStack{
//                ForEach(vm.surveys, id: \.id){surveys in
//                    if (surveys.email == email ){
//                        HStack{
//                            Image("apple").resizable().scaledToFit().frame(height:100).padding()
//                            VStack{
//                                HStack{
//                                    Text(surveys.name)
//                                    Spacer()
//                                    Button(action: {
//                                        self.action = 1
//                                    }){
//                                        Text("Edit")
//                                            .padding(.horizontal)
//                                            .padding(.vertical, 5)
//                                            .background(.mint)
//                                            .foregroundColor(.white)
//                                            .cornerRadius(10)
//                                    }
//
//
//                                }
//                                if let email = UserDefaults.standard.object(forKey: "email") as? String {
//                                    HStack{
//                                        Text(email)
//                                        Spacer()
//                                    }
//                                }
//
//                                HStack{
//                                    Image("star").resizable().scaledToFit().frame(height:20)
//                                    Text("4.8")
//                                    Spacer()
//                                }
//                            }
//
//
//
//                        }.listRowSeparator(.hidden)
//
//                        VStack{
//                            HStack{
//                                Text("Hosted Event")
//                                Spacer()
//                                Text("10")
//                            }.padding(.horizontal,50)
//                                .padding()
//                            HStack{
//                                Text("Attended Event")
//                                Spacer()
//                                Text("5")
//                            }.padding(.horizontal,50)
//                                .padding()
//                            HStack{
//                                Text("Partners")
//                                Spacer()
//                                Text("10")
//                            }.padding(.horizontal,50)
//                                .padding()
//                            HStack{
//                                Text("Preferred Sport")
//                                Spacer()
//                                Button(action: {}){
//                                    Image(systemName: "plus").foregroundColor(.mint)
//                                }
//
//                            }
//                            .padding(.horizontal,50)
//                            .padding()
//                            HStack{
//                                ForEach(surveys.favoriteSport, id: \.self){ sport in
//                                    Text(sport)
//                                        .multilineTextAlignment(.center)
//                                        .padding()
//                                        .frame(width: 120, height: 60)
//                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.mint).shadow( radius: 3))
//                                        .foregroundColor(.white)
//
//
//                                }
//                            }.padding()
//
//
//                        }
//                    }
//                    //                    if(!defaults.bool(forKey: "login")) {
//                    //                        LazyVStack{
//                    //                            Text("Sign up to manage your preferences")
//                    //                            NavigationLink(destination: LoginView(toMainPage: $isContentView),isActive: $isContentView){
//                    //                                EmptyView()
//                    //                                //                                Text("Here")
//                    //                                //                                    .bold()
//                    //                                //                                    .foregroundColor(.mint)
//                    //                                //                                    .underline()
//                    //                            }
//                    //
//                    //                            Button("Here"){
//                    //                                isContentView = true
//                    //                            }
//                    //                        }.padding(.vertical, 25)
//                    //
//                    //                    }else{
//                    //
//                    //                    }
//                }
//                .padding()
//                Spacer()
//            }.onAppear{
//                vm.fetchSurvey()
//            }
//        }.navigationBarHidden(true)
//

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







//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}


