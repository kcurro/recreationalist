//
//  TabBar.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/17/21.
//

import SwiftUI

struct TabBar: View {
    @EnvironmentObject var state: AppState
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
        TabView(selection: $state.selectedOption) {
              SearchView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Search")
                }
                .tag(Tab.site)
                
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(Tab.profile)
                
            CollectionsView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Collections")
                }
                .tag(Tab.collection)

            MoreView()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("More")
                }
                .tag(Tab.more)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
