//
//  CollectionDetailView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 4/22/21.
//

import SwiftUI
import FirebaseFirestore
import MapKit
import CoreLocation


struct CollectionDetailView: View {
    @ObservedObject var favorite: Favorite
    @EnvironmentObject var session: FirebaseSession
    @EnvironmentObject var appState: AppState

    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                PointView(location: favorite.location)
                
                HStack {
                    Text("\(favorite.city), \(favorite.state)")
                }
                
                Button(action: {
                    print("Floating Button Click To Get Directions")
                    //used https://www.youtube.com/watch?v=QXkuWZLARDA as tutorial
                    let latitude: CLLocationDegrees = favorite.location.latitude
                    let longitude: CLLocationDegrees = favorite.location.longitude
                    let regionDistance: CLLocationDistance = 1000
                    let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
                    
                    let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
                    
                    let placeMark = MKPlacemark(coordinate : coordinates)
                    let mapItem = MKMapItem(placemark: placeMark)
                    mapItem.name = "\(favorite.name)"
                    mapItem.openInMaps(launchOptions: options)
                }, label: {
                    Text("Get Directions")
                        .font(.system(size:18))
                })
                
                Divider()
                
                Text("Details")
                    .font(.largeTitle)
                
                Button(action: {
                    print("Floating Button Click");
                    RemoveFavorites()
                }, label: {
                    HStack{
                        Text("Remove Favorite")
                            .font(.system(size:15))
                        Image(systemName: "star.fill")
                    }
                })
                
                
                HStack {
                    Text(favorite.siteDetails)
                        .font(.system(size:15))
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                
                Divider()

                VStack(alignment: .center){
                    Button(action: {
                        print("Floating Button Click");
                    }, label: {
                        NavigationLink(destination: LoadReviews(siteName: favorite.name)) {
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
                        NavigationLink(destination: AddReview(siteName: favorite.name)) {
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
        .navigationTitle(favorite.name)
    }
    func RemoveFavorites() {
        //function to delete from favorites
        //to delete from favorites we find where documents are equal to the user id and site name
        favsCollectionRef.whereField("name", isEqualTo: favorite.name).whereField("user_id", isEqualTo: session.loggedInUser?.uid ?? "nil").getDocuments() { querySnapshot, err in
            if let err = err {
                print("Error deleting document: \(err)")
            } else {
                for document in querySnapshot!.documents {
                      document.reference.delete()
                    print("Document sucessfully removed!")
                }
            }
        }
    }
}

struct favoriteReview: View {
    var body: some View{
        VStack(alignment: .leading){
            
        }
    }
}


/*struct CollectionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionDetailView()
    }
}*/
