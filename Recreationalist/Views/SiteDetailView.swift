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
                
                Divider()

                Text("Details")
                    .font(.largeTitle)
            
                HStack {
                    Text(site.siteDetails)
                        .font(.system(size:15))
                    Spacer()
                }
                
                Divider()

            
                Text("Reviews")
                    .font(.largeTitle)
                Spacer()
            }
        } .padding()
        .navigationTitle(site.name)
    }
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
