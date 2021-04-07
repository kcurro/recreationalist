//
//  SiteListView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/24/21.
//

import SwiftUI
import FirebaseFirestore

let sitesCollectionRef = Firestore.firestore().collection("recSites")

struct SiteListView: View {

    @ObservedObject private var sites: FirebaseCollection<Site>
    
    private var sitesQuery: Query
    
    //@Binding var search: String
    
    init() {
        self.sitesQuery = sitesCollectionRef.order(by: "name")
        
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
}

struct SiteListView_Previews: PreviewProvider {
    static var previews: some View {
        SiteListView()
    }
}
