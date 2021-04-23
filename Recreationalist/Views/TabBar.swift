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
        /*nested in nav view based on https://stackoverflow.com/questions/58304009/how-to-debug-precondition-failure-in-xcode
         if this persists also refer to https://stackoverflow.com/questions/60028961/swiftui-crash-precondition-failure-attribute-failed-to-set-an-initial-value
        */
        TabView(selection: $state.selectedOption) {
            //NavigationView {
                SearchView()
            //}.padding(.top, -100)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Search")
                }
                .tag(Tab.site)
                
            //NavigationView {
                ProfileView()
            //}.padding(.top, -100)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(Tab.profile)
                
            //NavigationView {
                CollectionsView()
            //}.padding(.top, -100)
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Collections")
                }
                .tag(Tab.collection)

            NavigationView {
                MoreView()
            }.padding(.top, -100)
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
