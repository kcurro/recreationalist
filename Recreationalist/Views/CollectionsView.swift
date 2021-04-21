//
//  CollectionsView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/17/21.
//

import SwiftUI
import FirebaseFirestore

//currently this page is loading with all rec site data...
//update with correct firebase collection thinking this will be done on the user level collection
let sitesCollectionRef = Firestore.firestore().collection("recSites")

struct CollectionsView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
        NavigationView {
            Group {
                if (session.isSignedIn) {
                    /*CollectionInternalView(sites: FirebaseCollection<Site>(query: sitesCollectionRef.whereField("user_id", isEqualTo: session.user?.uid ?? "nil").order(by: "timestamp", descending: true)))*/
                    CollectionInternalView(sites: FirebaseCollection<Site>(query: sitesCollectionRef.order(by: "name")))
                } else {
                    Button("Sign in to view saved activities") {
                        appState.selectedOption = Tab.profile
                    }
                    .font(.headline)
                }
            }
            .navigationBarTitle("Saved Activities", displayMode: .inline)
        }
    }

    
    struct CollectionInternalView: View {
        @ObservedObject private var sites: FirebaseCollection<Site>
        
            //update init to sites
        init(sites: FirebaseCollection<Site>) {
            //update with correct firebase collection thinking this will be done on the user level collection
            self.sites = sites
        }
        
        var body: some View {
            //update with correct firebase collection thinking this will be done on the user level collection
            List{
                Section{
                    ForEach(sites.items) {
                        site in NavigationLink(destination: SiteDetailView(site: site)) {
                            SiteRow(site: site)
                        }
                    }
                }.disabled(sites.items.isEmpty)
            }
            .listStyle(GroupedListStyle())
        }
    }
}


/*
struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
    }
}*/
