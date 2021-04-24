//
//  ProfileView-SignedInView.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 4/17/21.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import SDWebImageSwiftUI

let profileCollectionRef = Firestore.firestore().collection("profiles")

struct ProfileView_SignedInView: View {
    //MARK: -PROPERTIES
    @EnvironmentObject var session: FirebaseSession
    @EnvironmentObject var appState: AppState
    
    //MARK: -BODY
    @ViewBuilder
    var body: some View {
        if session.hasSignedUp == true && appState.hasCreatedProfile == false  {
            ProfileView_CreateProfile()
        } else {
            SignedInView(profile: FirebaseCollection<Profile>(query: profileCollectionRef.whereField("userID", isEqualTo: session.loggedInUser?.uid ?? "nil")))
        }
    }
}

struct SignedInView: View {
    //MARK: -PROPERTIES
    @EnvironmentObject var session: FirebaseSession
    @ObservedObject private var profile: FirebaseCollection<Profile>
    
    init(profile: FirebaseCollection<Profile>) {
        self.profile = profile
    }
    
    private var data = ["186,467\nACTIVITES","0\nREVIEWS"]
    private var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State private var activitiesAlert = false
    @State private var urlImage = URL(string: "")
    
    //MARK: -BODY
    var body: some View {
        //MARK: -SCROLL VIEW
        
        //says my array is empty
        //when I tried to debug
        Print("This is my profile items array:\(profile.items)")
        
        ScrollView{
            //MARK: -VSTACK
            VStack{
                Section{
                    //MARK: -HSTACK
                    HStack{
                        ZStack{
                            if urlImage == URL(string:"") {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
                                    .foregroundColor(Color.gray)
                            } else {
                                WebImage(url: urlImage)
                                    .resizable()
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                    .shadow(radius:7)
                                    .frame(width:95, height:95)
                            }
                        }.onAppear(perform: loadImageFromFirebase)
                        .padding()
                        //MARK: -VSTACK
                        VStack(alignment:.leading){
                            
                            if profile.items.count == 0 {
                                Text("Anonymous")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            } else {
                                Text(profile.items[0].fullName)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            }
                            
                            LazyVGrid(columns: threeColumnGrid) {
                             ForEach(data, id: \.self){
                                item in Text(item).font(.caption)
                             }
                            }
                        }//: VSTACK
                        }//:HSTACK
                }
                Section(header: Text("My Stats").font(.headline)){
                    Spacer()
                }
                Section(header: Text("Activities").font(.headline)){
                    Spacer()
                    HStack{
                       Button(action: { print("I was clicked!")}) {
                            Image(systemName: "list.bullet")
                                .resizable()
                                .frame(width:60, height:55)
                                .foregroundColor(Color.yellow)
                                .padding()
                                    }
                        Text("186,467\nTRACKED").font(.body)
                    }
                }
                Section(header: Text("Reviews").font(.headline)){
                    Spacer()
                    HStack{
                       Button(action: { print("I was clicked!")}) {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .frame(width:60, height:55)
                                .foregroundColor(Color.yellow)
                                .padding()
                                    }
                        Text("0\nREVIEWS").font(.body)
                    }
                }
            }//: VSTACK
        }.navigationBarHidden(true)//: SCROLL VIEW
    }
    
    func loadImageFromFirebase(){
        guard let userID: String = session.loggedInUser?.uid else { return }
        print("This is the userID: \(userID)")
        
        let name = userID + ".jpeg"
        let storage = Storage.storage().reference(withPath:"userImages/").child("\(name)")
        //download image URL from Storage
        storage.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            //last step we set the image url
            self.urlImage = url!
        }
    }
}

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}

struct ProfileView_SignedInView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView_SignedInView()
    }
}
