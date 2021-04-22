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
                
                HStack {
                    Text(favorite.siteDetails)
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
                            NavigationLink(destination: favoriteReview()) {
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
            }
            .padding()
        }
        .navigationTitle(favorite.name)
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
