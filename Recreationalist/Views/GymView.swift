//
//  GymView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/27/21.
//

import SwiftUI
import FirebaseFirestore

let gymsCollectionRef = Firestore.firestore().collection("recSites")

struct GymView: View {
    @ObservedObject private var sites: FirebaseCollection<Site>
        
    private var sitesQuery: Query
        
    init() {
        self.sitesQuery = gymsCollectionRef.whereField("gyms", isEqualTo: true).order(by: "name")
            
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
        .navigationBarTitle("Gyms", displayMode: .inline)
    }
}

struct GymView_Previews: PreviewProvider {
    static var previews: some View {
        GymView()
    }
}
