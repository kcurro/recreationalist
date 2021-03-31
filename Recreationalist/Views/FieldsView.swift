//
//  FieldsView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/27/21.
//

import SwiftUI
import FirebaseFirestore

let fieldsCollectionRef = Firestore.firestore().collection("recSites")

struct FieldsView: View {
    @ObservedObject private var sites: FirebaseCollection<Site>
        
    private var sitesQuery: Query
        
    init() {
        self.sitesQuery = fieldsCollectionRef.whereField("fields", isEqualTo: true).order(by: "name")
            
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
        .navigationBarTitle("Courts & Fields", displayMode: .inline)
    }
}

struct FieldsView_Previews: PreviewProvider {
    static var previews: some View {
        FieldsView()
    }
}
