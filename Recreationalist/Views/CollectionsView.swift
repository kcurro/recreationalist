//
//  CollectionsView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/17/21.
//

import SwiftUI
import FirebaseFirestore

//update with correct firebase collection thinking this will be done on the user level collection
//let trailsCollectionRef = Firestore.firestore().collection("recSites")

struct CollectionsView: View {
    //update with correct firebase collection thinking this will be done on the user level collection
    //@ObservedObject private var sites: FirebaseCollection<Site>
    
    //private var sitesQuery: Query
        
    init() {
        /*self.sitesQuery = parksCollectionRef.whereField("parks", isEqualTo: true).order(by: "name")
            
        self.sites = FirebaseCollection<Site>(query: sitesQuery)*/
    }
    
    var body: some View {
        List{
            //update with correct firebase collection thinking this will be done on the user level collection
            
            /*ForEach(sites.items) {
                site in NavigationLink(destination: SiteDetailView(site: site)) {
                    SiteRow(site: site)
                }
            }*/
            
        }
        .navigationBarTitle("Saved Collection", displayMode: .inline)
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
    }
}
