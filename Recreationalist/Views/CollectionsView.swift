//
//  CollectionsView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/17/21.
//

import SwiftUI
import FirebaseFirestore

//updated with correct firebase collection
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
        //updated with correct firebase collection
            self.favorites = favorites
        }
        
        var body: some View {
            //updated with correct firebase collection
            List{
                Section{
                    ForEach(favorites.items) {
                        favorite in NavigationLink(destination: CollectionDetailView(favorite: favorite)) {
                            CollectionRow(favorite: favorite)
                        }
                    }
                }
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
