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
    @State private var selection: String? = nil

    //@State var navHidden: Bool = true
        
    var body: some View {
        NavigationView {
            ZStack{
                Image("hiking")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center, spacing:30) {
                    Text("Search for Recreational Activites")
                        //can eventually remove this out keeping for right now
                        .font(.system(size:25))
                        .padding()
                    Button(action: {
                        print("Floating Button Click To Use Current Location");
                        self.selection = "Users Location"
                    }, label: {
                        NavigationLink(destination: UserSearch() , tag: "Users Location", selection: $selection) {
                            Text("Search With Current Location")
                        }
                    })
                    HStack {
                        TextField("Search by city...", text: $search)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .disableAutocorrection(true)
                            .padding(.horizontal)
                        if self.search != "" {
                            Button(action: {
                                self.search = ""
                            }) {
                                Text("Clear")
                            }
                            Button(action: {
                                print("Floating Button Click");
                                self.selection = "User Search"
                            }, label: {
                                NavigationLink(destination: UserSearch() , tag: "User Search", selection: $selection) {
                                    Text("Search")
                                }
                            })
                        }
                    }
                    Spacer()
                }
                .navigationBarTitle("Recreationalist")
            }
        }
    }
}

/*struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}*/
