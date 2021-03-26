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

    var searchOptions: [String] = ["Trails", "Parks", "Gyms", "Courts & Fields", "Pools", "Classes"]
    
    var body: some View {
        //VStack(alignment: .center, spacing:30) {
          //  Text("Recreationalist")
            //    .font(.system(size:40))
              //  .bold()
        NavigationView {
            ScrollView{
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
                    }
                } .padding()
                //if self.search != "" {
                //    Text("No results")
                //} else {
                    //SiteListView()
                //}
                VStack{
                    /*
                Button(action: {
                    print("Floating Button Click")
                }, label: {
                    NavigationLink(destination: SiteListView()) {
                         Text("Trails")
                     }
                })
                Button(action: {
                    print("Floating Button Click")
                }, label: {
                    NavigationLink(destination: SiteListView()) {
                         Text("Parks")
                     }
                })

                Button(action: {
                    print("Floating Button Click")
                }, label: {
                    NavigationLink(destination: SiteListView()) {
                         Text("Gyms")
                     }
                })

                Button(action: {
                    print("Floating Button Click")
                }, label: {
                    NavigationLink(destination: SiteListView()) {
                         Text("Courts & Fields")
                     }
                })

                Button(action: {
                    print("Floating Button Click")
                }, label: {
                    NavigationLink(destination: SiteListView()) {
                         Text("Pools")
                     }
                })

                Button(action: {
                    print("Floating Button Click")
                }, label: {
                    NavigationLink(destination: SiteListView()) {
                         Text("Classes")
                     }
                })*/
                    NavigationLink(destination: SiteListView()) {
                        Text("Trails")
                    }
                    NavigationLink(destination: SiteListView()) {
                        Text("Parks")
                    }
                    NavigationLink(destination: SiteListView()) {
                        Text("Gyms")
                    }
                    NavigationLink(destination: SiteListView()) {
                        Text("Courts & Fields")
                    }
                    NavigationLink(destination: SiteListView()) {
                        Text("Pools")
                    }
                    NavigationLink(destination: SiteListView()) {
                        Text("Classes")
                    }

                } .padding()
            }
                .navigationBarTitle("Recreationalist")
        }
    }
}
                /*TextField("Search for a recreational activity...", text: $search)
                    //added padding here
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .disableAutocorrection(true)
                    .onTapGesture {
                        self.editing = true
                    }
                if self.editing{
                    //add functionality to clear search when editing is set to true aka user clicks text field
                }*/

            /*Button(action: {
                //add a query here to filter activities based on keyword park
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
            }*/
       // }
   // }
//}

/*struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}*/
