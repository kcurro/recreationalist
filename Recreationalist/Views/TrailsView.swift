//
//  TrailsView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/26/21.
//

import SwiftUI
import FirebaseFirestore

struct TrailsView: View {
    @ObservedObject private var sites: FirebaseCollection<Site>
        
    private var sitesQuery: Query
        
    init() {
        self.sitesQuery = sitesCollectionRef.whereField("trails", isEqualTo: true).order(by: "name")
            
        self.sites = FirebaseCollection<Site>(query: sitesQuery)
    }
        
    var body: some View {
        NavigationView{
            List{
                ForEach(sites.items) {
                    site in NavigationLink(destination: SiteDetailView(site: site)) {
                        SiteRow(site: site)
                    }
                }
            }
            .navigationBarTitle("Trails")
        }
    }
}

struct TrailsView_Previews: PreviewProvider {
    static var previews: some View {
        TrailsView()
    }
}
