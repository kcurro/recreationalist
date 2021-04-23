//
//  SiteDetailView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/24/21.
//

import SwiftUI
import FirebaseFirestore
import MapKit
import CoreLocation
import FirebaseStorage
import SDWebImageSwiftUI

let reviewsCollectionRef = Firestore.firestore().collection("reviews")


struct SiteDetailView: View {
    @ObservedObject var site: Site
    @EnvironmentObject var session: FirebaseSession
    @EnvironmentObject var appState: AppState

    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                PointView(location: site.location)
                
                HStack {
                    Text("\(site.city), \(site.state)")
                }
                
                Button(action: {
                    print("Floating Button Click To Get Directions")
                    //used https://www.youtube.com/watch?v=QXkuWZLARDA as tutorial
                    let latitude: CLLocationDegrees = site.location.latitude
                    let longitude: CLLocationDegrees = site.location.longitude
                    let regionDistance: CLLocationDistance = 1000
                    let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
                    
                    let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
                    
                    let placeMark = MKPlacemark(coordinate : coordinates)
                    let mapItem = MKMapItem(placemark: placeMark)
                    mapItem.name = "\(site.name)"
                    mapItem.openInMaps(launchOptions: options)
                }, label: {
                    Text("Get Directions")
                        .font(.system(size:18))
                })
                
                Divider()
                
                Text("Details")
                    .font(.largeTitle)
                
                if session.loggedInUser != nil {
                    Button(action: {
                        print("Floating Button Click");
                        AddFavorites()
                    }, label: {
                        HStack{
                            Text("Add Favorite")
                                .font(.system(size:15))
                            Image(systemName: "star.fill")
                        }
                    })
                } else {
                    Button("Sign In To Add Favorite") {
                        appState.selectedOption = Tab.profile
                    }
                }
                
                HStack {
                    Text(site.siteDetails)
                        .font(.system(size:15))
                    Spacer()
                }
                
                Divider()

            
                HStack{
                    Text("Reviews")
                    .font(.largeTitle)
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()

                    //TO DO button to add a review and send the data to firebase to add to collections in firebase - add a view for the reviews if user is signed in they cant do anything if user clicks it and not signed in the user is told to sign in
                    if session.loggedInUser != nil {
                        Button(action: {
                            print("Floating Button Click");
                        }, label: {
                            NavigationLink(destination: AddReview(site: site)) {
                                Text("Sign In To Review")
                                    .font(.system(size:15))
                                    .fontWeight(.semibold)
                            }
                        })
                    } else {
                        Button("Add a Review") {
                            appState.selectedOption = Tab.profile
                        }
                    }
                    
                    Spacer()
                }
                //load in reviews that match the current site name here
                LoadReviews(site: site)
            }
            .padding()
        }
        .navigationTitle(site.name)
        //adding a trailing button on the navigation bar for adding to favorites
        /*.navigationBarItems(trailing: Button(action: {
            print("Floating Button Click To Add To Favorites");
        }, label: {
            NavigationLink(destination: AddFavorites(site: site)){
                HStack{
                    Text("Add Favorite")
                        .font(.system(size:10))
                    Image(systemName: "star.fill")
                }
            }
        })
    )*/
        
    }
    func AddFavorites () {
        //if the user is signed in it will store the site data and the users UID and save it into firebase collection favorites
        let data = ["name": site.name,
                    "city": site.city,
                    "state": site.state,
                    "siteDetails": site.siteDetails,
                    "location": site.location,
                    "logo": site.logo,
                    "user_id": session.loggedInUser?.uid ?? "nil"]
        as [String: Any]
        
        //post to firebase as a new document
        
        //add in conditional that there exists no document with user id and site name already
        let favs = favsCollectionRef.whereField("name", isEqualTo: site.name).whereField("user_id", isEqualTo: session.loggedInUser?.uid ?? "nil")
            favs.getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting firestore documents: \(err)")
            } else{
                if let snapshotDocuments = querySnapshot?.documents {
                    if snapshotDocuments.isEmpty{
                        favsCollectionRef.addDocument(data: data) { err in
                            if let err = err {
                                print("Error adding document: \(err)")
                            } else {
                                print("Document sucessfully added!")
                            }
                        }
                    } else {
                        for document in snapshotDocuments {
                            do{
                                print("Already stored as favorite with ID: \(document.documentID)")
                            }
                        }
                    }
                }
            }
        }
    }//closes out function
}

/*struct SiteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SiteDetailView()
    }
}*/

/*
 how to incorporate geopoint from firebase -> https://stackoverflow.com/questions/66378588/swiftui-how-to-fetch-geopoint-from-cloud-firestore-and-display-it
*/
 struct PointView : View {
    var location : GeoPoint

    struct IdentifiablePoint: Identifiable {
        var id = UUID()
        var location : GeoPoint
    }
    
    var body: some View {
        Map(coordinateRegion: .constant(
                MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))), annotationItems: [location].map { IdentifiablePoint(location: $0)}) { point in
            MapPin(coordinate: CLLocationCoordinate2D(latitude: point.location.latitude, longitude: point.location.longitude))
        }
        .ignoresSafeArea(edges: .top)
        .frame(height: 200)
    }
}

struct AddReview: View {
    //TO DO button to add a review and send the data to firebase to add to collections in firebase - add a view for the reviews if user is signed in they cant do anything if user clicks it and not signed in the user is told to sign in
    var site: Site
    @State var entry: String = ""
    @State var timestamp: String = ""
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View{
        VStack(alignment: .leading){
            TextField("Today's Date DD/MM/YYYY Format", text: $timestamp)
                .disableAutocorrection(true)
                .font(.system(size: 16))
            
            TextField("Write Your Review", text: $entry)
                .disableAutocorrection(true)
                .font(.system(size: 16))
            
            Button(action: submit) {
                Text("Submit")
            }
        }
    }
    
    func submit() {
        writeReviewToFirebase()
        resetTextFields()
    }
    
    func writeReviewToFirebase(){
        let data = ["name": site.name,
                    "entry": entry,
                    "timestamp": Timestamp(),
                    "user_id": session.loggedInUser?.uid ?? "nil",
                    "image": "",
                    "username": "" ]
        as [String: Any]
        
        //post data to firebase as a new document
        var ref: DocumentReference? = nil
        ref = reviewsCollectionRef.addDocument(data: data) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func resetTextFields(){
        entry = ""
        timestamp = ""
    }
}
struct LoadReviews: View {
    @ObservedObject private var reviews: FirebaseCollection<Review>
    var site: Site
    
    private var reviewsQuery: Query
        
    init() {
        self.reviewsQuery = reviewsCollectionRef.whereField("name", isEqualTo: site.name).order(by: "timestamp")
            
        self.reviews = FirebaseCollection<Review>(query: reviewsQuery)
    }
    
    var body: some View {
        List{
            ForEach(reviews.items) {
                review in ReviewRow(review: review)
            }
        }
    }
}
