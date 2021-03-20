//
//  TabBar.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/17/21.
//

import SwiftUI

struct TabBar: View {
    @State var choice = 0
    
    var body: some View {
        TabView(selection: $choice) {
              SearchView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Search")
                }
                
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                
            CollectionsView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Collections")
                }

             MoreView()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("More")
                }
            }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
