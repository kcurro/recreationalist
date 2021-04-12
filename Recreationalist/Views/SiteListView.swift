//
//  SiteListView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/24/21.
//

import SwiftUI
import FirebaseFirestore
import MapKit

let sitesCollectionRef = Firestore.firestore().collection("recSites")

struct SiteListView: View {

    @ObservedObject private var sites: FirebaseCollection<Site>
    
    var sitesQuery: Query
    
    //@ObservedObject private var locationManager = LocationManager()
        
    @EnvironmentObject var locationManager: LocationManager

    
    init() {
        self.sitesQuery = sitesCollectionRef.order(by: "name")
        self.sites = FirebaseCollection<Site>(query: sitesQuery)
    }
        
    var body: some View {
        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate : CLLocationCoordinate2D()
        
        print("coordinate in site list view \(coordinate)")
        let lat = 0.0144927536231884
        let lon = 0.0181818181818182
        let distance = 200
        let lowerLat = coordinate.latitude - (lat * Double(distance))
        let lowerLon = coordinate.longitude - (lon * Double(distance))
        let greaterLat = coordinate.latitude + (lat * Double(distance))
        let greaterLon = coordinate.longitude + (lon * Double(distance))
        let lesserGeopoint = GeoPoint(latitude: lowerLat, longitude: lowerLon)
        let greaterGeopoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)

        print("lesser geopoint: \(lesserGeopoint)")
        print("greater geopoint: \(greaterGeopoint)")
        
        let sitesQuery = sitesCollectionRef.whereField("location", isLessThanOrEqualTo: greaterGeopoint).whereField("location", isGreaterThanOrEqualTo: lesserGeopoint).order(by: "location")
        let sites = FirebaseCollection<Site>(query: sitesQuery)

        return List{
            ForEach(sites.items) {
                site in NavigationLink(destination: SiteDetailView(site: site)) {
                    SiteRow(site: site)
                }
            }
        }
        .navigationBarTitle("All Sites", displayMode: .inline)
    }
    
   /* mutating func UpdatedQuery() {
            let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate : CLLocationCoordinate2D()
            
            print("coordinate in site list view \(coordinate)")
            
            let lat = 0.0144927536231884
            let lon = 0.0181818181818182
            let distance = 5
            let lowerLat = coordinate.latitude - (lat * Double(distance))
            let lowerLon = coordinate.longitude - (lon * Double(distance))
            let greaterLat = coordinate.latitude + (lat * Double(distance))
            let greaterLon = coordinate.longitude + (lon * Double(distance))
            let lesserGeopoint = GeoPoint(latitude: lowerLat, longitude: lowerLon)
            let greaterGeopoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)

            print("lesser geopoint: \(lesserGeopoint)")
            print("greater geopoint: \(greaterGeopoint)")
            
            
            self.sitesQuery = sitesCollectionRef.whereField("location", isLessThanOrEqualTo: greaterGeopoint).whereField("location", isGreaterThanOrEqualTo: lesserGeopoint).order(by: "location")

            self.sites = FirebaseCollection<Site>(query: sitesQuery)
            
    }*/
}

/*struct SiteListView_Previews: PreviewProvider {
    static var previews: some View {
        SiteListView()
    }
}*/

