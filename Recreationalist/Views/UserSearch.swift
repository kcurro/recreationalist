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
    @StateObject var userLocation = UserLocation()
    var example = [CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)]


    //@Binding var search: String
    //added
    //@EnvironmentObject var location: UserLocation

    //let fetchUserLocation = UserLocation()

    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 30){
            MapView(location: userLocation.myLocation ?? location: example)
            
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
    }
}

/*struct UserSearch_Previews: PreviewProvider {
    static var previews: some View {
        UserSearch()
    }
}*/

/*
struct MapView: UIViewRepresentable {
    var locationManager = CLLocationManager()
     
     func setupManager() {
       locationManager.desiredAccuracy = kCLLocationAccuracyBest
       locationManager.requestWhenInUseAuthorization()
       locationManager.requestAlwaysAuthorization()
     }
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        setupManager()
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
    }
 }*/
 



    /*let mapView = MKMapView()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        checkLocationServices()
    }
    
    func setupMapView() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: 4000, longitudinalMeters: 4000)
        mapView.setRegion(region, animated: true)
    }
   
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            followUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show alert
            break
        case .authorizedAlways:
            break
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // the user didn't turn it on
        }
    }
    
    func followUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 4000, longitudinalMeters: 4000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }*/
 /*
 struct MapView {
     var coordinate: CLLocationCoordinate2D

     func makeMapView() -> MKMapView {
         MKMapView(frame: .zero)
     }

     func updateMapView(_ view: MKMapView, context: Context) {
         let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
         let region = MKCoordinateRegion(center: coordinate, span: span)
         view.setRegion(region, animated: true)
     }
 }

 #if os(macOS)

 extension MapView: NSViewRepresentable {
     func makeNSView(context: Context) -> MKMapView {
         makeMapView()
     }
     
     func updateNSView(_ nsView: MKMapView, context: Context) {
         updateMapView(nsView, context: context)
     }
 }

 #else

 extension MapView: UIViewRepresentable {
     func makeUIView(context: Context) -> MKMapView {
         makeMapView()
     }
     
     func updateUIView(_ uiView: MKMapView, context: Context) {
         updateMapView(uiView, context: context)
     }
 }

 #endif
*/

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
