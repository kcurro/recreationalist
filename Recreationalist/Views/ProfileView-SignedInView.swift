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
import HealthKit

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
        healthStore = HealthStore()
    }
    
    //private var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    private var threeColumnGrid = [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0),GridItem(.flexible(), spacing: 0)]
    @State private var activitiesAlert = false
    @State private var urlImage = URL(string: "")
    
    //health kit properties and function *************************************************************************
    private var healthStore: HealthStore?
    @State private var step: Step?
    
    private func updateUIFromStatistics(statiscticsCollection: HKStatisticsCollection) {
        
        //start date retrieving a week of step counts but only want current day
        //might have to change later on for now leave as it is
        let startDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        //the date that is today
        let endDate = Date()
        
        statiscticsCollection.enumerateStatistics(from: startDate, to: endDate){ (statisctics, stop) in
            let count = statisctics.sumQuantity()?.doubleValue(for: .count())
            
            step = Step(count: Int(count ?? 0), date: statisctics.startDate)
        }
    }
    
    //health kit properties and function end here ****************************************************************
    
    //MARK: -BODY
    var body: some View {
        //MARK: -SCROLL VIEW
        
        Print("This is my profile items array:\(profile.items)")
        Print("This is my review items array:\(review.items)")
        Print("This is the step count: \(step?.count ?? 0)")
        
        let data = ["\(step?.count ?? 0)\nSTEPS","\(review.items.count)\nREVIEWS"]
        
        //MARK: -NAVIGATION VIEW
        NavigationView{
            //MARK: -VSTACK
            VStack(alignment: .leading){
                //display profile image and quick stats
                Section{
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
                                    .shadow(radius:10)
                                    .frame(width:100, height:100, alignment: .center)
                            }
                        }.onAppear(perform: loadImageFromFirebase)
                        
                        .padding()
                        
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
                            
                            LazyVGrid(columns: threeColumnGrid, alignment: .leading) {
                                ForEach(data, id: \.self){
                                    item in Text(item).font(.caption)
                                }
                            }
                        }
                    }
                }
                
                //display My Stats
                Section(header: Text("My Stats").font(.headline).padding(.bottom, -10.0)){
                    
                }.padding()
                
                //display step button
                Section(header: Text("Steps").font(.headline).padding(.bottom, -10.0)){
                    HStack{
                        VStack{
                            Button(action: {
                                print("Floating Button Click");
                            }, label: {
                                NavigationLink(destination: LoadSteps()) {
                                    Image(systemName: "hare.fill")
                                        .resizable()
                                        .frame(width:60, height:55)
                                        .foregroundColor(Color.purple)
                                        .padding()
                                }
                            })
                        }
                        
                        Text("\(step?.count ?? 0)\nSTEPS").font(.body)
                    }
                }.padding()
                
                //display review button
                Section(header: Text("Reviews").font(.headline).padding(.bottom, -10.0)){
                    HStack{
                        VStack{
                            Button(action: {
                                print("Floating Button Click");
                            }, label: {
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
                }.padding()
            }.padding(.bottom, 300.0)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true) //:NAVIGATION VIEW
        
        //added onAppear for health kit
        .onAppear{
            if let healthStore = healthStore {
                healthStore.requestAuthorization { success in
                    if success {
                        healthStore.calculateSteps { statisticsCollection in
                            if let statisticsCollection = statisticsCollection {
                                print(statisticsCollection) //for debugging purposes
                                //update the UI
                                updateUIFromStatistics(statiscticsCollection: statisticsCollection)
                            }
                        }
                    }
                }
            }
        }
        //onAppear health kit ends here
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

struct LoadSteps: View {
    
    private var healthStore: HealthStore?
    @State private var step: Step?
    
    init() {
        healthStore = HealthStore()
    }
    
    private func updateUIFromStatistics(statiscticsCollection: HKStatisticsCollection) {
        
        //start date retrieving a week of step counts but only want current day
        //might have to change later on for now leave as it is
        let startDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        //the date that is today
        let endDate = Date()
        
        statiscticsCollection.enumerateStatistics(from: startDate, to: endDate){ (statisctics, stop) in
            let count = statisctics.sumQuantity()?.doubleValue(for: .count())
            
            step = Step(count: Int(count ?? 0), date: statisctics.startDate)

        }
    }
    
    var body: some View {
        
        VStack(alignment: .center){
            Text("Great Work Today!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.purple)
                .padding()
            Text("Step Count: \(step?.count ?? 0)")
                .bold()
                .font(.system(size: 18.0))
            Text(step?.date ?? Date(), style: .date)
                .opacity(0.5)
                .font(.system(size: 18.0))
        }.navigationBarTitle("Todays Step Count", displayMode: .inline)
        
            .onAppear{
                if let healthStore = healthStore {
                    healthStore.requestAuthorization { success in
                        if success {
                            healthStore.calculateSteps { statisticsCollection in
                                if let statisticsCollection = statisticsCollection {
                                    print(statisticsCollection) //for debugging purposes
                                    //update the UI
                                    updateUIFromStatistics(statiscticsCollection: statisticsCollection)
                                }
                            }
                        }
                    }
                }
            }
    }
    
}

struct ProfileView_SignedInView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView_SignedInView()
    }
}
