//
//  SearchView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/17/21.
//

import SwiftUI

struct SearchView: View {
    @State var editing = false
    @State var search: String = ""
    @State var choice = 0

    
    var body: some View {
        VStack(alignment: .center, spacing:30) {
            Text("Recreationalist")
                .font(.system(size:40))
                .bold()
            //NavigationView {
                TextField("Search for a recreational activity...", text: $search)
                    .background(Color(.secondarySystemBackground))
                    .disableAutocorrection(true)
                    .onTapGesture {
                        self.editing = true
                    }
                if self.editing{
                    //add functionality to clear search when editing is set to true aka user clicks text field
                }
            //}
            Button(action: {
                //add a query here to filter activities based on keyword trail/hike
            }) {
                Text("Trails")
                    .font(.system(size: 18))
            }
            Button(action: {
                //add a query here to filter activities based on keyword park
            }) {
                Text("Parks")
                .font(.system(size: 18))
            }
            Button(action: {
                //add a query here to filter activities based on keyword gym
            }) {
                Text("Gyms")
                    .font(.system(size: 18))
            }
            Button(action: {
                //add a query here to filter activities based on keyword court/field
            }) {
                Text("Courts & Fields")
                    .font(.system(size: 18))
            }
            Button(action: {
                //add a query here to filter activities based on keyword pools
            }) {
                Text("Pools")
                    .font(.system(size: 18))
            }
            Button(action: {
                    //add a query here to filter activities based on keyword classes
            }) {
                Text("Classes")
                    .font(.system(size: 18))
            }
        }
        .padding(30)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
