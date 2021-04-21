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


struct SiteDetailView: View {
    @ObservedObject var site: Site
    
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

                    //TO DO button to add a review and send the data to firebase to add to collections in firebase - add a view for the reviews if user is signed in they cant do anything if user clicks it and not signed in the user is told to sign in 
                    Button(action: {
                        print("Floating Button Click");
                    }, label: {
                        Text("Add a Review")
                            .font(.system(size:15))
                            .fontWeight(.semibold)
                    })
                    
                    Spacer()
                }
            }
            .padding()
        }
        .navigationTitle(site.name)
        //adding a trailing button on the navigation bar for adding to favorites
        .navigationBarItems(trailing: Button(action: {
            print("Floating Button Click To Add To Favorites");
        }, label: {
            HStack{
                Text("Add Favorite")
                    .font(.system(size:10))
                Image(systemName: "star.fill")
            }
        })
    )}
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
