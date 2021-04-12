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
    
    private var sitesQuery: Query
    
    @ObservedObject private var locationManager = LocationManager()
    
    //@EnvironmentObject var locationManager: LocationManager

    
    init() {
        /*let lat = 0.0144927536231884
        let lon = 0.0181818181818182
        let distance = 5
            
        let lowerLat = locationManager.location?.coordinate.latitude ?? 0 - (lat * Double(distance))
        let lowerLon = locationManager.location?.coordinate.longitude ?? 0 - (lon * Double(distance))

        let greaterLat = locationManager.location?.coordinate.latitude ?? 0 + (lat * Double(distance))
        let greaterLon = locationManager.location?.coordinate.longitude ?? 0 + (lon * Double(distance))
        let lesserGeopoint = GeoPoint(latitude: lowerLat, longitude: lowerLon)
        let greaterGeopoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)*/
        self.sitesQuery = sitesCollectionRef.order(by: "name")
        self.sites = FirebaseCollection<Site>(query: sitesQuery)
        makeQuery()

        
        //self.sitesQuery = trailsCollectionRef.whereField("trails", isEqualTo: true).order(by: "name")

        
        //makeQuery()
        /*self.sitesQuery = sitesCollectionRef.whereField("longitude", isLessThanOrEqualTo: coordinate.longitude).whereField("longitude", isGreaterThanOrEqualTo: coordinate.latitude).whereField("longitude", isLessThanOrEqualTo: coordinate.longitude).whereField("latitude", isGreaterThanOrEqualTo: coordinate.longitude).order(by: "name")
        
        //self.sitesQuery = trailsCollectionRef.whereField("trails", isEqualTo: true).order(by: "name")*/

        
        self.sites = FirebaseCollection<Site>(query: sitesQuery)
    }
        
    var body: some View {
        List{
            ForEach(sites.items) {
                site in NavigationLink(destination: SiteDetailView(site: site)) {
                    SiteRow(site: site)
                }
            }
        }
        .navigationBarTitle("All Sites", displayMode: .inline)
    }
    
    mutating func makeQuery(){
        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate : CLLocationCoordinate2D()
        
        let lat = 0.0144927536231884
        let lon = 0.0181818181818182
        let distance = 5
        let lowerLat = coordinate.latitude - (lat * Double(distance))
        let lowerLon = coordinate.longitude - (lon * Double(distance))

        let greaterLat = coordinate.latitude + (lat * Double(distance))
        let greaterLon = coordinate.longitude + (lon * Double(distance))

        let lesserGeopoint = GeoPoint(latitude: lowerLat, longitude: lowerLon)
        let greaterGeopoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)
        
        self.sitesQuery = sitesCollectionRef.whereField("location", isLessThanOrEqualTo: greaterGeopoint).whereField("location", isGreaterThanOrEqualTo: lesserGeopoint).order(by: "name")

        self.sites = FirebaseCollection<Site>(query: sitesQuery)
        //self.sitesQuery = trailsCollectionRef.whereField("trails", isEqualTo: true).order(by: "name")

        
        //self.sites = FirebaseCollection<Site>(query: sitesQuery)
    }
}

/*struct SiteListView_Previews: PreviewProvider {
    static var previews: some View {
        SiteListView()
    }
}*/
