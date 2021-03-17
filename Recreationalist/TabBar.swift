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
                Button("Search"){
                    //add functionality here for page navigation
                }
                .padding()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Search")
                }
                
                Button("Profile"){
                    //add functionality here for page navigation
                }
                .padding()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                
                Button("Collections"){
                    //add functionality here for page navigation
                }
                .padding()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Collections")
                }

                Button("More"){
                    //add functionality here for page navigation
                }
                .padding()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("More")
                }
            }
        //}
    }
}
