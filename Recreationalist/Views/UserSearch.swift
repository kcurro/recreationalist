//
//  UserSearch.swift
//  Recreationalist
//
//  Created by Katrina Curro on 4/6/21.
//

import SwiftUI
import MapKit
import UIKit

struct UserSearch: View {

    @State private var selection: String? = nil
    var userLocation = UserLocation()
    @State private var currentUserLocation = CLLocationCoordinate2D()

    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 30){
            MapView(location: currentUserLocation)
            
            Button(action: {
                print("Floating Button Click");
                self.selection = "All Sites"
            }, label: {
                NavigationLink(destination: SiteListView() , tag: "All Sites", selection: $selection) {
                    Text("All Sites - No Filtering")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Trails Button Click");
                self.selection = "Trails Only"
            }, label: {
                NavigationLink(destination: TrailsView(), tag: "Trails Only", selection: $selection){
                    Text("Trails")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Parks Button Click");
                self.selection = "Parks Only"
            }, label: {
                NavigationLink(destination: ParksView(), tag: "Parks Only", selection: $selection){
                    Text("Parks")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Gym Button Click");
                self.selection = "Gyms Only"
            }, label: {
                NavigationLink(destination: GymView(), tag: "Gyms Only", selection: $selection){
                    Text("Gyms")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Fields Button Click");
                self.selection = "Fields Only"
            }, label: {
                NavigationLink(destination: FieldsView(), tag: "Fields Only", selection: $selection){
                    Text("Courts & Fields")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Pools Button Click");
                self.selection = "Pools Only"
            }, label: {
                NavigationLink(destination: PoolsView(), tag: "Pools Only", selection: $selection){
                    Text("Pools")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Classes Button Click");
                self.selection = "Classes Only"
            }, label: {
                NavigationLink(destination: ClassesView(), tag: "Classes Only", selection: $selection){
                    Text("Classes")
                        .fontWeight(.semibold)
                }
            })
        }//vstack
        .navigationBarTitle("Result Filtered", displayMode: .inline)
        .onAppear(perform: getCurrentLocation)
    }
    
    func getCurrentLocation() {
            let lat = userLocation.lastLocation?.coordinate.latitude ?? 0
            let log = userLocation.lastLocation?.coordinate.longitude ?? 0

            self.currentUserLocation.latitude = lat
            self.currentUserLocation.longitude = log
    }
}

/*struct UserSearch_Previews: PreviewProvider {
    static var previews: some View {
        UserSearch()
    }
}*/


/*struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var currentLocation : CLLocationCoordinate2D
    
     func setupManager() {
       locationManager.desiredAccuracy = kCLLocationAccuracyBest
       locationManager.requestWhenInUseAuthorization()
       locationManager.requestAlwaysAuthorization()
     }
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        setupManager()
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {

    }
 }*/

struct MapView : View {
    var location : CLLocationCoordinate2D

   struct IdentifiablePoint: Identifiable {
       var id = UUID()
       var location : CLLocationCoordinate2D
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

