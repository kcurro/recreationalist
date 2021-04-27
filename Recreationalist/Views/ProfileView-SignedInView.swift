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
let reviewCollectionRef = Firestore.firestore().collection("reviews")

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
            SignedInView(profile: FirebaseCollection<Profile>(query: profileCollectionRef.whereField("userID", isEqualTo: session.loggedInUser?.uid ?? "nil")), review: FirebaseCollection<Review>(query: reviewCollectionRef.whereField("user_id", isEqualTo: session.loggedInUser?.uid ?? "nil")) )
        }
    }
}

struct SignedInView: View {
    //MARK: -PROPERTIES
    @EnvironmentObject var session: FirebaseSession
    @ObservedObject private var profile: FirebaseCollection<Profile>
    @ObservedObject private var review: FirebaseCollection<Review>
    
    init(profile: FirebaseCollection<Profile>, review: FirebaseCollection<Review>) {
        self.profile = profile
        self.review = review
    }
    
    //private var data = ["186,467\nACTIVITES","0\nREVIEWS"]
    private var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State private var activitiesAlert = false
    @State private var urlImage = URL(string: "")
    
    //MARK: -BODY
    var body: some View {
        //MARK: -SCROLL VIEW
        
        Print("This is my profile items array:\(profile.items)")
        Print("This is my review items array:\(review.items)")
        
        let data = ["186,467\nACTIVITES","\(review.items.count)\nREVIEWS"]
        
        NavigationView{
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
                        //VStack(alignment:.leading)
                        VStack(alignment: .leading){
                            
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
                }
                Section(header: Text("Activities").font(.headline)){
                    HStack{
                       Button(action: { print("I was clicked!")}) {
                            Image(systemName: "list.bullet")
                                .resizable()
                                .frame(width:60, height:55)
                                .foregroundColor(Color.purple)
                                .padding()
                                    }
                        Text("186,467\nTRACKED").font(.body)
                    }
                }
                Section(header: Text("Reviews").font(.headline)){
                    HStack{
                        VStack{
                            Button(action: {
                                print("Floating Button Click");
                            }, label: {
                                //its not going to the NavigationLink when clicked hmmm
                                NavigationLink(destination: LoadProfileReviews(user_id: session.loggedInUser?.uid ?? "nil")) {
                                    Image(systemName: "square.and.pencil")
                                        .resizable()
                                        .frame(width:60, height:55)
                                        .foregroundColor(Color.purple)
                                        .padding()
                                }
                            })
                        }
                        Text("\(review.items.count)\nREVIEWS").font(.body)
                    }
                }
            }.padding(.top, -440)//: VSTACK
        }
        .navigationBarHidden(true)//: NAVIGATION VIEW
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

struct LoadProfileReviews: View {
    var user_id: String
    @ObservedObject private var reviews: FirebaseCollection<Review>
    
    private var reviewsQuery: Query
        
    init(user_id: String) {
        self.user_id = user_id
        self.reviewsQuery = reviewCollectionRef.whereField("user_id", isEqualTo: user_id).order(by: "timestamp")
        let reviewCollection = FirebaseCollection<Review>(query: reviewsQuery)
        self.reviews = reviewCollection
    }
    
    var body: some View {
        Print("This is my reviews items array from LoadProfileReviews:\(reviews.items)")
        List{
            Section{
                ForEach(reviews.items) {
                    review in ReviewRow(review: review)
                }
            }.disabled(reviews.items.isEmpty)
        }.listStyle(GroupedListStyle())
        .navigationBarTitle("Reviews", displayMode: .inline)
    }
}

struct ProfileView_SignedInView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView_SignedInView()
    }
}
