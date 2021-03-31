//
//  ParksView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/26/21.
//

import SwiftUI
import FirebaseFirestore

let parksCollectionRef = Firestore.firestore().collection("recSites")

struct ParksView: View {
    @ObservedObject private var sites: FirebaseCollection<Site>
        
    private var sitesQuery: Query
        
    init() {
        self.sitesQuery = parksCollectionRef.whereField("parks", isEqualTo: true).order(by: "name")
            
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
        .navigationBarTitle("Parks", displayMode: .inline)
    }
}

struct ParksView_Previews: PreviewProvider {
    static var previews: some View {
        ParksView()
    }
}
