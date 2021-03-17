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
        //NavigationView {
        TabView(selection: $choice) {
              SearchView()
                .padding()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Search")
                }
                
                /*Button("Profile"){
                    //add functionality here for page navigation
                }*/
            ProfileView()
                .padding()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                
            CollectionsView()
                .padding()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Collections")
                }

             /*
             //add in more page
                .padding()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("More")
                }*/
            }
        //}
    }
}
