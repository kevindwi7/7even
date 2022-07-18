//
//  ProfileView.swift
//  7even
//
//  Created by Kevin  Dwi on 24/06/22.
//

import SwiftUI
import CloudKit

struct ProfileView: View {
    @StateObject  var vm: MainViewModel
    
    @State var isShowing = false
    @State var action: Int? = 0
    @State var isContentView = false
    @State var isEditProfileView = false
    @State var isPreferredSportView = false
    
    let defaults = UserDefaults.standard
    @State var usersID = UserDefaults.standard.object(forKey: "userID") as? String
    
    init(vm: MainViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationView{
            if(!defaults.bool(forKey: "login")){
                ScrollView(.vertical){
                    Spacer()
                    VStack(alignment: .leading){
                        LazyVStack{
                            
                            
                            Text("Sign up to manage your profile")
                            NavigationLink(destination: LoginView(toMainPage: $isContentView, vm: vm),isActive: $isContentView){
                                EmptyView()
                                //
                            }
                            Button("Here"){
                                isContentView = true
                            }
                        }.padding(.vertical, 25)
                        Spacer()
                    }.onAppear{
                        vm.fetchSurvey()
                    }
                    
                    Spacer()
                } .navigationTitle("Profile")
                    .navigationBarTitleDisplayMode(.inline)
                
            }else{
                ScrollView(.vertical){
                    VStack(alignment: .leading){
                        ForEach(vm.surveys, id: \.id){ surveys in
                            if (surveys.userID == usersID){
                                VStack{
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
                                                    Text(surveys.name).font(.system(size: 24, weight: .bold))
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
                                                Text("\(surveys.age) Tahun").font(.system(size: 16))
                                                Spacer()
                                            }
                                            .padding(.horizontal, 24)
                                            
                                            HStack{
                                                Text("Gender").font(.system(size: 16)).multilineTextAlignment(.center)
                                                Spacer()
                                                Text(surveys.sex).font(.system(size: 16)).multilineTextAlignment(.center)
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
                                                Text(surveys.sportWith)
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
                                                NavigationLink(destination: EditPreferredSportView(toMainPage: $isPreferredSportView, selectedSport: []), isActive: $isPreferredSportView){
                                                    EmptyView()
                                                    //
                                                }
                                                Button(action: {
                                                    isPreferredSportView = true
                                                }){
                                                    Image(systemName: "plus").resizable().scaledToFit().frame(height: 18).foregroundColor(.mint)
                                                }
                                                
                                            }
                                            .padding(.horizontal, 24)
                                            .padding(.vertical,5)
                                            
                                            HStack{
                                                ForEach(surveys.favoriteSport, id: \.self){ sport in
                                                    Text(sport)
                                                        .multilineTextAlignment(.center)
                                                        .font(.system(size: 14,weight: .bold))
                                                        .frame(width: 120, height: 60)
                                                        .background(RoundedRectangle(cornerRadius: 12).stroke(.mint, lineWidth: 1).shadow(radius: 2))
                                                        .foregroundColor(.black)
                                                }
                                                
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
                                }
                            }
                        }
                        Spacer()
                    }.onAppear{
                        vm.fetchSurvey()
                    }
                    //                    .onReceive(vm.objectWillChange) { _ in
                    //                        vm.fetchSurvey()
                    //                    }
                    //
                    Spacer()
                }
                .onAppear{
                    print("eeewf")
                    //                    print("\(usersID) testtttt)")
                    usersID = UserDefaults.standard.object(forKey: "userID") as? String
                    
                    vm.fetchSurvey()
                }
                .onReceive(vm.objectWillChange) { _ in
                    if(defaults.bool(forKey: "login")){
                        vm.fetchSurvey()
                        //                    print(userID)
                        //                    print(vm.surveys.contains(where: { $0.userID == userID }))
                        if(vm.surveys.contains(where: { $0.userID == usersID })) {
                            vm.fetchSurvey()
                        }
                    }
                }
                
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ForEach($vm.surveys, id: \.id) { index in
                        NavigationLink(destination: EditProfileView(mainViewModel: MainViewModel(container: CKContainer.default()), survey: index , toMainPage: $isEditProfileView, favoriteSports: [])){
                            Text("Edit").foregroundColor(.mint)
                            //                                    .onTapGesture {
                            //                                    print("31 \(index)")
                            //                                }
                            
                        }
                        
                    }
                }
                //                    .toolbar{
                //                        forEach()
                //                        NavigationLink(destination: EditProfileView(mainViewModel: MainViewModel(container: CKContainer.default()), survey: survey.id , toMainPage: $isEditProfileView, favoriteSports: [])){
                //                            Text("Edit").foregroundColor(.mint)
                //                        }
                //
                //
                ////                        NavigationLink(destination: EditProfileView(mainViewModel: MainViewModel(container: CKContainer.default()),toMainPage: $isEditProfileView), isActive: $isEditProfileView){
                ////                            Text("Edit").foregroundColor(.mint)
                ////
                ////                        }
                //                    }
            }
            
            
        }
        
    }
    
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}


