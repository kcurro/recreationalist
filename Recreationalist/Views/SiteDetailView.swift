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
                        .fixedSize(horizontal: false, vertical: true)
                }
                Divider()
                
                    VStack(alignment: .center){
                        Button(action: {
                            print("Floating Button Click");
                        }, label: {
                            NavigationLink(destination: LoadReviews(siteName: site.name)) {
                                Text("See Reviews")
                                    .font(.largeTitle)
                            }
                        })
                    }

                    //TO DO button to add a review and send the data to firebase to add to collections in firebase - add a view for the reviews if user is signed in they cant do anything if user clicks it and not signed in the user is told to sign in
                    if session.loggedInUser != nil {
                        Button(action: {
                            print("Floating Button Click");
                        }, label: {
                            NavigationLink(destination: AddReview(siteName: site.name)) {
                                Text("Add a Review")
                                    .font(.system(size:15))
                                    .fontWeight(.semibold)
                            }
                        })
                    } else {
                        Button("Sign In To Add a Review") {
                            appState.selectedOption = Tab.profile
                        }
                    }
            }
            .padding()
        }
        .navigationTitle(site.name)
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
        .frame(height: 300)
    }
}

struct AddReview: View {
    //TO DO button to add a review and send the data to firebase to add to collections in firebase - add a view for the reviews if user is signed in they cant do anything if user clicks it and not signed in the user is told to sign in
    var siteName: String
    @EnvironmentObject var session: FirebaseSession
    @State var entry: String = ""
    @State var timestamp: String = ""
    
    @State private var imgPicker = false
    @State private var showSheet = false
    @State private var reviewImage: Image?
    @State private var inputImg: UIImage?
    
    var body: some View{
        VStack (spacing: 16){
            Spacer()
            
            Text("Click To Upload Image")
                .font(.system(size: 25))
            //take in user profile image from user
            ZStack{
                //trying to make it sameish formatting as create profile page
                if reviewImage != nil  {
                    reviewImage?
                        .resizable()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius:20)
                        .frame(width:200, height:200, alignment: .center)
                } else {
                    Image(systemName: "leaf.arrow.triangle.circlepath")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .shadow(radius: 20 )
                        .foregroundColor(Color.gray)
                }
            }
            .onTapGesture {
                self.imgPicker = true
            }
            //take in user profile image from user ends
            Spacer()
            
            TextField("Write Your Review", text: $entry)
                .disableAutocorrection(true)
                .font(.system(size: 16))
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.primary, lineWidth: 2))
            
            TextField("Date Visited Site", text: $timestamp)
                .disableAutocorrection(true)
                .font(.system(size: 16))
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.primary, lineWidth: 2))
            
            Button(action: {
                saveImage()
                writeReviewToFirebase()
            }, label: {
                Text("Submit")
                    .fontWeight(.semibold)
            })
            
        } .sheet(isPresented: $imgPicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImg)
        } .padding(.vertical, 16)
        .frame(width: 288)
    }
    
    //image picker functions
    func loadImage(){
        guard let inputImg = inputImg else {return}
        reviewImage = Image(uiImage: inputImg)
    }
    
    func saveImage(){
        guard let user_id: String = session.loggedInUser?.uid else { return }
        //store using userID and timestamp
        let filename = user_id + "_" + siteName + ".jpeg"
        guard let reviewImage = inputImg else {return}
        guard let data: Data = reviewImage.jpegData(compressionQuality: 0.5) else {return}
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        let storage = Storage.storage().reference(withPath:"reviewImages/").child("\(filename)")
        
        //place image into Storage
        storage.putData(data, metadata: metadata)
    }
    
    
    func writeReviewToFirebase(){
        //getting username and storing to reviews collection to be able to show it in reviews
        let docRef = Firestore.firestore().collection("profiles").document(session.loggedInUser?.uid ?? "nil")
        // Get data
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                print(dataDescription?["full_name"] as Any)
                let data = ["name": siteName,
                            "entry": entry,
                            "timestamp": timestamp,
                            "user_id": session.loggedInUser?.uid ?? "nil",
                            "image": "reviewImages/\(session.loggedInUser?.uid ?? "nil")_\(siteName).jpeg",
                            "username": dataDescription?["full_name"] as Any ]
                as [String: Any]
                var ref: DocumentReference? = nil
                ref = reviewsCollectionRef.addDocument(data: data) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                        resetTextFields()
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
        
        /*let data = ["name": siteName,
                    "entry": entry,
                    "timestamp": timestamp,
                    "user_id": session.loggedInUser?.uid ?? "nil",
                    "image": "reviewImages/\(session.loggedInUser?.uid ?? "nil")_\(timestamp).jpeg",
                    "username": getName ]
        as [String: Any]
        
        //post data to firebase as a new document
        var ref: DocumentReference? = nil
        ref = reviewsCollectionRef.addDocument(data: data) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }*/
    }
    
    func resetTextFields(){
        entry = ""
        timestamp = ""
    }
}

struct LoadReviews: View {
    var siteName: String
    @ObservedObject private var reviews: FirebaseCollection<Review>
    
    private var reviewsQuery: Query
        
    init(siteName: String) {
        self.siteName = siteName
        self.reviewsQuery = reviewsCollectionRef.whereField("name", isEqualTo: siteName).order(by: "timestamp")
        let reviewCollection = FirebaseCollection<Review>(query: reviewsQuery)
        self.reviews = reviewCollection
    }
    
    var body: some View {
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
