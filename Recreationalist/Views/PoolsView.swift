//
//  PoolsView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/27/21.
//

import SwiftUI
import FirebaseFirestore

let poolsCollectionRef = Firestore.firestore().collection("recSites")

struct PoolsView: View {
    @ObservedObject private var sites: FirebaseCollection<Site>
        
    private var sitesQuery: Query
        
    init() {
        self.sitesQuery = poolsCollectionRef.whereField("pools", isEqualTo: true).order(by: "name")
            
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
    }
}

struct PoolsView_Previews: PreviewProvider {
    static var previews: some View {
        PoolsView()
    }
}
