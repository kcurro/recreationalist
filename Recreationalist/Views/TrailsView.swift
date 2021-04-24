//
//  TrailsView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/26/21.
//

/*
import SwiftUI
import FirebaseFirestore
import MapKit

let trailsCollectionRef = Firestore.firestore().collection("recSites")


struct TrailsView: View {
    @ObservedObject private var sites: FirebaseCollection<Site>
        
    private var sitesQuery: Query
    
    @ObservedObject private var locationManager = LocationManager()
    
    var siteArray = [FirebaseCollection<Site>]()
    
    private var coordinate: CLLocationCoordinate2D

        
    init() {
        /*self.sitesQuery = trailsCollectionRef.whereField("trails", isEqualTo: true).order(by: "name")
            
        let collection = FirebaseCollection<Site>(query: sitesQuery)
        self.sites = collection*/
        self.coordinate = locationManager.location != nil ? locationManager.location!.coordinate : CLLocationCoordinate2D()
        
        //print("coordinate in site list view \(self.coordinate)")
        
        let lat = 0.0144927536231884
        let lon = 0.0181818181818182
        let distance = 5 //5 miles out
        let lowerLat = coordinate.latitude - (lat * Double(distance))
        let lowerLon = coordinate.longitude - (lon * Double(distance))
        let greaterLat = coordinate.latitude + (lat * Double(distance))
        let greaterLon = coordinate.longitude + (lon * Double(distance))
        
        let lesserGeopoint = GeoPoint(latitude: lowerLat, longitude: lowerLon)
        let greaterGeopoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)

        print("lesser geopoint: \(lesserGeopoint)")
        print("greater geopoint: \(greaterGeopoint)")
        
        self.sitesQuery = trailsCollectionRef.whereField("trails", isEqualTo: true).whereField("location", isLessThanOrEqualTo: greaterGeopoint).whereField("location", isGreaterThanOrEqualTo: lesserGeopoint).order(by: "location")
        
        let collection = FirebaseCollection<Site>(query: sitesQuery)
        self.sites = collection
        
        //test if query is null
        sitesQuery.getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in snapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
            }
    }
        
    var body: some View {
       /* let coordinate = locationManager.location != nil ? locationManager.location!.coordinate : CLLocationCoordinate2D()
        
        print("coordinate in site list view \(coordinate)")
        
        let lat = 0.0144927536231884
        let lon = 0.0181818181818182
        let distance = 5 //5 miles out
        let lowerLat = coordinate.latitude - (lat * Double(distance))
        let lowerLon = coordinate.longitude - (lon * Double(distance))
        let greaterLat = coordinate.latitude + (lat * Double(distance))
        let greaterLon = coordinate.longitude + (lon * Double(distance))
        
        let lesserGeopoint = GeoPoint(latitude: lowerLat, longitude: lowerLon)
        let greaterGeopoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)

        print("lesser geopoint: \(lesserGeopoint)")
        print("greater geopoint: \(greaterGeopoint)")
        
        let sitesQuery = trailsCollectionRef.whereField("trails", isEqualTo: true).whereField("location", isLessThanOrEqualTo: greaterGeopoint).whereField("location", isGreaterThanOrEqualTo: lesserGeopoint).order(by: "location")
        
        let sites = FirebaseCollection<Site>(query: sitesQuery)
        
        //test if query is null
        sitesQuery.getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in snapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
            }*/
        
        
        VStack(alignment: .center, spacing: 30){
            //TrailMapView(location: coordinate)
            List{
                ForEach(sites.items) {
                    site in NavigationLink(destination: SiteDetailView(site: site)) {
                        SiteRow(site: site)
                    }
                }
            }
            //ListView(location: coordinate, sites: sites)
        }
        .navigationBarTitle("Trails", displayMode: .inline)
    }
}

/*struct TrailsView_Previews: PreviewProvider {
    static var previews: some View {
        TrailsView()
    }
}*/

struct TrailMapView : View {
    //@Binding var location : CLLocationCoordinate2D
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

struct ListView : View {
    var location: CLLocationCoordinate2D
    var sites: FirebaseCollection<Site>

    var body: some View {
    /*let locs = [0.0144927536231884, 0.0181818181818182, 5]
    let lowerLat = location.latitude - (locs[0] * Double(locs[2]))
    let lowerLon = location.longitude - (locs[1] * Double(locs[2]))
    let greaterLat = location.latitude + (locs[0] * Double(locs[2]))
    let greaterLon = location.longitude + (locs[1] * Double(locs[2]))
    
    let lesserGeopoint = GeoPoint(latitude: lowerLat, longitude: lowerLon)
    let greaterGeopoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)

        print("lesser geopoint: \(lesserGeopoint)")
        print("greater geopoint: \(greaterGeopoint)")
    let usitesQuery = trailsCollectionRef.whereField("trails", isEqualTo: true).whereField("location", isLessThanOrEqualTo: greaterGeopoint).whereField("location", isGreaterThanOrEqualTo: lesserGeopoint).order(by: "location")
    let usites = FirebaseCollection<Site>(query: usitesQuery)*/
        
         List{
            ForEach(sites.items) {
                site in NavigationLink(destination: SiteDetailView(site: site)) {
                    SiteRow(site: site)
                }
            }
        }
    }
    /*func load(){
        let locs = [0.0144927536231884, 0.0181818181818182, 5]
        let lowerLat = location.latitude - (locs[0] * Double(locs[2]))
        let lowerLon = location.longitude - (locs[1] * Double(locs[2]))
        let greaterLat = location.latitude + (locs[0] * Double(locs[2]))
        let greaterLon = location.longitude + (locs[1] * Double(locs[2]))
        
        let lesserGeopoint = GeoPoint(latitude: lowerLat, longitude: lowerLon)
        let greaterGeopoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)

            print("lesser geopoint: \(lesserGeopoint)")
            print("greater geopoint: \(greaterGeopoint)")
        
        let usitesQuery = trailsCollectionRef.whereField("trails", isEqualTo: true).whereField("location", isLessThanOrEqualTo: greaterGeopoint).whereField("location", isGreaterThanOrEqualTo: lesserGeopoint).order(by: "location")
        let collection = FirebaseCollection<Site>(query: usitesQuery)
        let usites = collection
    }*/
}

*/
