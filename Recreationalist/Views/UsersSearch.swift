//
//  UsersSearch.swift
//  Recreationalist
//
//  Created by Katrina Curro on 4/21/21.
//

import SwiftUI
import MapKit
import UIKit
import FirebaseFirestore

struct UsersSearch: View {

    @State private var selection: String? = nil
    
    //anytime this throws or publishes an event it gives us the view values
    @ObservedObject private var locationManager = LocationManager()

    var body: some View {
        //checking if not nil if its not nil we unwrap it
        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate : CLLocationCoordinate2D()
        
        return VStack(alignment: .center, spacing: 30){
            //MapView(location: $currentUserLocation)
            MapView(location: coordinate)
            //printing out users location on screen
            Text("Your current location is: \(coordinate.latitude), \(coordinate.longitude)")
                .font(.system(size:10))
            
            Button(action: {
                print("Trails Button Click");
                self.selection = "Trails Only"
            }, label: {
                NavigationLink(destination: TrailsView(location: coordinate), tag: "Trails Only", selection: $selection){
                    Text("Trails")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Parks Button Click");
                self.selection = "Parks Only"
            }, label: {
                NavigationLink(destination: ParksView(location: coordinate), tag: "Parks Only", selection: $selection){
                    Text("Parks")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Gym Button Click");
                self.selection = "Gyms Only"
            }, label: {
                NavigationLink(destination: GymView(location: coordinate), tag: "Gyms Only", selection: $selection){
                    Text("Gyms")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Fields Button Click");
                self.selection = "Fields Only"
            }, label: {
                NavigationLink(destination: FieldsView(location: coordinate), tag: "Fields Only", selection: $selection){
                    Text("Courts & Fields")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Pools Button Click");
                self.selection = "Pools Only"
            }, label: {
                NavigationLink(destination: PoolsView(location: coordinate), tag: "Pools Only", selection: $selection){
                    Text("Pools")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Classes Button Click");
                self.selection = "Classes Only"
            }, label: {
                NavigationLink(destination: ClassesView(location: coordinate), tag: "Classes Only", selection: $selection){
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

struct MapView : View {
    var location: CLLocationCoordinate2D

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


let trailsCollectionRef = Firestore.firestore().collection("recSites")

struct TrailsView: View {
    @ObservedObject private var sites: FirebaseCollection<Site>
        
    private var sitesQuery: Query
    
    @ObservedObject private var locationManager = LocationManager()
        
    var location: CLLocationCoordinate2D

        //reference code for formula https://stackoverflow.com/questions/56674470/flutter-firestore-geo-query
    init(location: CLLocationCoordinate2D) {
        self.location = location
        print("coordinate in site list init view \(self.location)")
        
        let lat = 0.0144927536231884
        let lon = 0.0181818181818182
        let distance = 5 //5 miles out
        let lowerLat = location.latitude - (lat * Double(distance))
        let lowerLon = location.longitude - (lon * Double(distance))
        let greaterLat = location.latitude + (lat * Double(distance))
        let greaterLon = location.longitude + (lon * Double(distance))
        
        let lesserGeopoint = GeoPoint(latitude: lowerLat, longitude: lowerLon)
        let greaterGeopoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)

        print("lesser geopoint: \(lesserGeopoint)")
        print("greater geopoint: \(greaterGeopoint)")
        
        self.sitesQuery = trailsCollectionRef.whereField("trails", isEqualTo: true).whereField("location", isLessThanOrEqualTo: greaterGeopoint).whereField("location", isGreaterThanOrEqualTo: lesserGeopoint).order(by: "location")
        
        let collection = FirebaseCollection<Site>(query: sitesQuery)
        self.sites = collection
        
        //test if query is null
        /*sitesQuery.getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in snapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
            }*/
    }
        
    var body: some View {
        List{
            Section{
                ForEach(sites.items) {
                    site in NavigationLink(destination: SiteDetailView(site: site)) {
                        SiteRow(site: site)
                    }
                }
            }.disabled(sites.items.isEmpty)
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Trails", displayMode: .inline)
    }
}

let parksCollectionRef = Firestore.firestore().collection("recSites")

struct ParksView: View {
    @ObservedObject private var sites: FirebaseCollection<Site>
        
    private var sitesQuery: Query
    
    @ObservedObject private var locationManager = LocationManager()
        
    var location: CLLocationCoordinate2D

        
    init(location: CLLocationCoordinate2D) {
        self.location = location
        print("coordinate in site list init view \(self.location)")
        
        let lat = 0.0144927536231884
        let lon = 0.0181818181818182
        let distance = 5 //5 miles out
        let lowerLat = location.latitude - (lat * Double(distance))
        let lowerLon = location.longitude - (lon * Double(distance))
        let greaterLat = location.latitude + (lat * Double(distance))
        let greaterLon = location.longitude + (lon * Double(distance))
        
        let lesserGeopoint = GeoPoint(latitude: lowerLat, longitude: lowerLon)
        let greaterGeopoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)

        print("lesser geopoint: \(lesserGeopoint)")
        print("greater geopoint: \(greaterGeopoint)")
        
        self.sitesQuery = trailsCollectionRef.whereField("parks", isEqualTo: true).whereField("location", isLessThanOrEqualTo: greaterGeopoint).whereField("location", isGreaterThanOrEqualTo: lesserGeopoint).order(by: "location")
        
        let collection = FirebaseCollection<Site>(query: sitesQuery)
        self.sites = collection
        
        //test if query is null
        /*sitesQuery.getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in snapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
            }*/
    }
        
    var body: some View {
        List{
            Section{
                ForEach(sites.items) {
                    site in NavigationLink(destination: SiteDetailView(site: site)) {
                        SiteRow(site: site)
                    }
                }
            }.disabled(sites.items.isEmpty)
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Parks", displayMode: .inline)
    }
}
let gymsCollectionRef = Firestore.firestore().collection("recSites")

struct GymView: View {
    @ObservedObject private var sites: FirebaseCollection<Site>
        
    private var sitesQuery: Query
    
    @ObservedObject private var locationManager = LocationManager()
        
    var location: CLLocationCoordinate2D
        
    init(location: CLLocationCoordinate2D) {
        self.location = location
        print("coordinate in site list init view \(self.location)")
        
        let lat = 0.0144927536231884
        let lon = 0.0181818181818182
        let distance = 5 //5 miles out
        let lowerLat = location.latitude - (lat * Double(distance))
        let lowerLon = location.longitude - (lon * Double(distance))
        let greaterLat = location.latitude + (lat * Double(distance))
        let greaterLon = location.longitude + (lon * Double(distance))
        
        let lesserGeopoint = GeoPoint(latitude: lowerLat, longitude: lowerLon)
        let greaterGeopoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)

        print("lesser geopoint: \(lesserGeopoint)")
        print("greater geopoint: \(greaterGeopoint)")
        
        self.sitesQuery = trailsCollectionRef.whereField("gyms", isEqualTo: true).whereField("location", isLessThanOrEqualTo: greaterGeopoint).whereField("location", isGreaterThanOrEqualTo: lesserGeopoint).order(by: "location")
        
        let collection = FirebaseCollection<Site>(query: sitesQuery)
        self.sites = collection
        
        //test if query is null
        /*sitesQuery.getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in snapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
            }*/
    }
    var body: some View {
        List{
            Section{
                ForEach(sites.items) {
                    site in NavigationLink(destination: SiteDetailView(site: site)) {
                        SiteRow(site: site)
                    }
                }
            }.disabled(sites.items.isEmpty)
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Gyms", displayMode: .inline)
    }
}
let fieldsCollectionRef = Firestore.firestore().collection("recSites")

struct FieldsView: View {
    @ObservedObject private var sites: FirebaseCollection<Site>
        
    private var sitesQuery: Query
    
    @ObservedObject private var locationManager = LocationManager()
        
    var location: CLLocationCoordinate2D
        
    init(location: CLLocationCoordinate2D) {
        self.location = location
        print("coordinate in site list init view \(self.location)")
        
        let lat = 0.0144927536231884
        let lon = 0.0181818181818182
        let distance = 5 //5 miles out
        let lowerLat = location.latitude - (lat * Double(distance))
        let lowerLon = location.longitude - (lon * Double(distance))
        let greaterLat = location.latitude + (lat * Double(distance))
        let greaterLon = location.longitude + (lon * Double(distance))
        
        let lesserGeopoint = GeoPoint(latitude: lowerLat, longitude: lowerLon)
        let greaterGeopoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)

        print("lesser geopoint: \(lesserGeopoint)")
        print("greater geopoint: \(greaterGeopoint)")
        
        self.sitesQuery = trailsCollectionRef.whereField("fields", isEqualTo: true).whereField("location", isLessThanOrEqualTo: greaterGeopoint).whereField("location", isGreaterThanOrEqualTo: lesserGeopoint).order(by: "location")
        
        let collection = FirebaseCollection<Site>(query: sitesQuery)
        self.sites = collection
        
        //test if query is null
        /*sitesQuery.getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in snapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
            }*/
    }
    var body: some View {
        List{
            Section{
                ForEach(sites.items) {
                    site in NavigationLink(destination: SiteDetailView(site: site)) {
                        SiteRow(site: site)
                    }
                }
            }.disabled(sites.items.isEmpty)
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Courts & Fields", displayMode: .inline)
    }
}

let poolsCollectionRef = Firestore.firestore().collection("recSites")

struct PoolsView: View {
    @ObservedObject private var sites: FirebaseCollection<Site>
        
    private var sitesQuery: Query
    
    @ObservedObject private var locationManager = LocationManager()
        
    var location: CLLocationCoordinate2D
        
    init(location: CLLocationCoordinate2D) {
        self.location = location
        print("coordinate in site list init view \(self.location)")
        
        let lat = 0.0144927536231884
        let lon = 0.0181818181818182
        let distance = 5 //5 miles out
        let lowerLat = location.latitude - (lat * Double(distance))
        let lowerLon = location.longitude - (lon * Double(distance))
        let greaterLat = location.latitude + (lat * Double(distance))
        let greaterLon = location.longitude + (lon * Double(distance))
        
        let lesserGeopoint = GeoPoint(latitude: lowerLat, longitude: lowerLon)
        let greaterGeopoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)

        print("lesser geopoint: \(lesserGeopoint)")
        print("greater geopoint: \(greaterGeopoint)")
        
        self.sitesQuery = trailsCollectionRef.whereField("pools", isEqualTo: true).whereField("location", isLessThanOrEqualTo: greaterGeopoint).whereField("location", isGreaterThanOrEqualTo: lesserGeopoint).order(by: "location")
        
        let collection = FirebaseCollection<Site>(query: sitesQuery)
        self.sites = collection
        
        //test if query is null
        /*sitesQuery.getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in snapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
            }*/
    }
    var body: some View {
        List{
            Section{
                ForEach(sites.items) {
                    site in NavigationLink(destination: SiteDetailView(site: site)) {
                        SiteRow(site: site)
                    }
                }
            }.disabled(sites.items.isEmpty)
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Pools", displayMode: .inline)
    }
}

let classesCollectionRef = Firestore.firestore().collection("recSites")

struct ClassesView: View {
    @ObservedObject private var sites: FirebaseCollection<Site>
        
    private var sitesQuery: Query
    
    @ObservedObject private var locationManager = LocationManager()
        
    var location: CLLocationCoordinate2D
        
    init(location: CLLocationCoordinate2D) {
        self.location = location
        print("coordinate in site list init view \(self.location)")
        
        let lat = 0.0144927536231884
        let lon = 0.0181818181818182
        let distance = 5 //5 miles out
        let lowerLat = location.latitude - (lat * Double(distance))
        let lowerLon = location.longitude - (lon * Double(distance))
        let greaterLat = location.latitude + (lat * Double(distance))
        let greaterLon = location.longitude + (lon * Double(distance))
        
        let lesserGeopoint = GeoPoint(latitude: lowerLat, longitude: lowerLon)
        let greaterGeopoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)

        print("lesser geopoint: \(lesserGeopoint)")
        print("greater geopoint: \(greaterGeopoint)")
        
        self.sitesQuery = trailsCollectionRef.whereField("classes", isEqualTo: true).whereField("location", isLessThanOrEqualTo: greaterGeopoint).whereField("location", isGreaterThanOrEqualTo: lesserGeopoint).order(by: "location")
        
        let collection = FirebaseCollection<Site>(query: sitesQuery)
        self.sites = collection
        
        //test if query is null
        /*sitesQuery.getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in snapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
            }*/
    }
    var body: some View {
        List{
            Section{
                ForEach(sites.items) {
                    site in NavigationLink(destination: SiteDetailView(site: site)) {
                        SiteRow(site: site)
                    }
                }
            }.disabled(sites.items.isEmpty)
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Classes", displayMode: .inline)
    }
}

