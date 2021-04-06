//
//  SiteListView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/24/21.
//

import SwiftUI
import FirebaseFirestore

let sitesCollectionRef = Firestore.firestore().collection("recSites")

struct SiteListView: View {

    @ObservedObject private var sites: FirebaseCollection<Site>
    
    private var sitesQuery: Query
    
    init() {
        self.sitesQuery = sitesCollectionRef.order(by: "name")
        
        self.sites = FirebaseCollection<Site>(query: sitesQuery)
    }
    
    @State private var filter = false
    @State private var selection: String? = nil

    
    var body: some View {
        List{
            ForEach(sites.items) {
                site in NavigationLink(destination: SiteDetailView(site: site)) {
                    SiteRow(site: site)
                }
            }
        }
        .navigationBarTitle("All Sites", displayMode: .inline)
        /*.navigationBarItems(trailing:
            HStack {
                Button(action: {
                    print("Trails Button Click");
                    self.selection = "Trails Only"
                }, label: {
                    NavigationLink(destination: TrailsView(), tag: "Trails Only", selection: $selection){
                    Text("Trails")
                    }
                })
                                    
                Button(action: {
                    print("Parks Button Click");
                    self.selection = "Parks Only"
                }, label: {
                    NavigationLink(destination: ParksView(), tag: "Parks Only", selection: $selection){
                    Text("Parks")
                    }
                })
                                    
                Button(action: {
                    print("Gym Button Click");
                    self.selection = "Gyms Only"
                }, label: {
                    NavigationLink(destination: GymView(), tag: "Gyms Only", selection: $selection){
                    Text("Gyms")
                    }
                })
                                    
                Button(action: {
                    print("Fields Button Click");
                    self.selection = "Fields Only"
                }, label: {
                    NavigationLink(destination: FieldsView(), tag: "Fields Only", selection: $selection){
                        Text("Courts & Fields")
                    }
                })
                                    
                Button(action: {
                    print("Pools Button Click");
                    self.selection = "Pools Only"
                }, label: {
                    NavigationLink(destination: PoolsView(), tag: "Pools Only", selection: $selection){
                    Text("Pools")
                    }
                })
                                                    
                Button(action: {
                    print("Classes Button Click");
                    self.selection = "Classes Only"
                }, label: {
                    NavigationLink(destination: ClassesView(), tag: "Classes Only", selection: $selection){
                    Text("Classes")
                    }
                })
            }
        )
        .navigationViewStyle(StackNavigationViewStyle())*/
        
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                VStack {
                    HStack {
                        Button(action: {
                            print("Trails Button Click");
                            self.selection = "Trails Only"
                        }, label: {
                            NavigationLink(destination: TrailsView(), tag: "Trails Only", selection: $selection){
                                Text("Trails")
                                }
                        })
                                        
                        Button(action: {
                            print("Parks Button Click");
                            self.selection = "Parks Only"
                        }, label: {
                            NavigationLink(destination: ParksView(), tag: "Parks Only", selection: $selection){
                                Text("Parks")
                            }
                        })
                                        
                        Button(action: {
                            print("Gym Button Click");
                            self.selection = "Gyms Only"
                        }, label: {
                            NavigationLink(destination: GymView(), tag: "Gyms Only", selection: $selection){
                                Text("Gyms")
                            }
                        })
                                        
                        Button(action: {
                            print("Fields Button Click");
                            self.selection = "Fields Only"
                        }, label: {
                            NavigationLink(destination: FieldsView(), tag: "Fields Only", selection: $selection){
                                Text("Courts & Fields")
                            }
                        })
                                        
                        Button(action: {
                            print("Pools Button Click");
                            self.selection = "Pools Only"
                        }, label: {
                            NavigationLink(destination: PoolsView(), tag: "Pools Only", selection: $selection){
                                Text("Pools")
                            }
                        })
                                                            
                        Button(action: {
                            print("Classes Button Click");
                            self.selection = "Classes Only"
                        }, label: {
                            NavigationLink(destination: ClassesView(), tag: "Classes Only", selection: $selection){
                                Text("Classes")
                            }
                        })
                    }
                }
                Image(systemName: "line.horizontal.3.decrease.circle")
            }
        }
    }
}

struct SiteListView_Previews: PreviewProvider {
    static var previews: some View {
        SiteListView()
    }
}

