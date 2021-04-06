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
    @State var navHidden: Bool = true
        
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing:30) {
                Text("Search for Recreational Activites")
                    .font(.system(size:25))
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
                        self.selection = "All Sites"
                    }, label: {
                        NavigationLink(destination: SiteListView() , tag: "All Sites", selection: $selection) {
                            Text("Search")
                            }
                        })
                    }
                } .padding()
                // to do ** change these to filter options
                /*
                Text("Sites by Activity Near Me")
                    .font(.system(size:25))
                
                Button(action: {
                    print("Trails Button Click");
                    self.selection = "Trails Only"
                }, label: {
                    NavigationLink(destination: TrailsView(), tag: "Trails Only", selection: $selection){
                        Text("Trails")
                            .font(.system(size:20))
                    }
                })
                    
                Button(action: {
                    print("Parks Button Click");
                    self.selection = "Parks Only"
                }, label: {
                    NavigationLink(destination: ParksView(), tag: "Parks Only", selection: $selection){
                        Text("Parks")
                            .font(.system(size:20))
                    }
                })
                    
                Button(action: {
                    print("Gym Button Click");
                    self.selection = "Gyms Only"
                }, label: {
                    NavigationLink(destination: GymView(), tag: "Gyms Only", selection: $selection){
                        Text("Gyms")
                            .font(.system(size:20))
                    }
                })
                    
                Button(action: {
                    print("Fields Button Click");
                    self.selection = "Fields Only"
                }, label: {
                    NavigationLink(destination: FieldsView(), tag: "Fields Only", selection: $selection){
                        Text("Courts & Fields")
                            .font(.system(size:20))
                    }
                })
                    
                Button(action: {
                    print("Pools Button Click");
                    self.selection = "Pools Only"
                }, label: {
                    NavigationLink(destination: PoolsView(), tag: "Pools Only", selection: $selection){
                        Text("Pools")
                            .font(.system(size:20))
                    }
                })
                                        
                Button(action: {
                    print("Classes Button Click");
                    self.selection = "Classes Only"
                }, label: {
                    NavigationLink(destination: ClassesView(), tag: "Classes Only", selection: $selection){
                        Text("Classes")
                            .font(.system(size:20))
                    }
                })*/
            }
            .navigationBarTitle("Recreationalist")
        }
    }
}

/*struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}*/
