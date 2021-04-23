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
let favsCollectionRef = Firestore.firestore().collection("favorites")

struct CollectionsView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
        NavigationView {
            Group {
                if session.loggedInUser != nil {
                    CollectionInternalView(favorites: FirebaseCollection<Favorite>(query: favsCollectionRef.whereField("user_id", isEqualTo: session.loggedInUser?.uid ?? "nil").order(by: "name")))
                } else {
                    Button("Sign in to view saved activities") {
                        appState.selectedOption = Tab.profile
                    }
                    .font(.headline)
                }
            }.navigationBarTitle("Saved Activities", displayMode: .inline)
        }
    }

    
    struct CollectionInternalView: View {
        @ObservedObject private var favorites: FirebaseCollection<Favorite>
        
        init(favorites: FirebaseCollection<Favorite>) {
        //update with correct firebase collection thinking this will be done on the user level collection
            self.favorites = favorites
        }
        
        var body: some View {
            //update with correct firebase collection thinking this will be done on the user level collection
            List{
                Section{
                    ForEach(favorites.items) {
                        favorite in NavigationLink(destination: CollectionDetailView(favorite: favorite)) {
                            CollectionRow(favorite: favorite)
                        }
                    }
                }//.disabled(favorites.items.isEmpty)
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
