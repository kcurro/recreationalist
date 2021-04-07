//
//  UserSearch.swift
//  Recreationalist
//
//  Created by Katrina Curro on 4/6/21.
//

import SwiftUI

struct UserSearch: View {
    @State private var selection: String? = nil
    //@Binding var search: String


    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 30){
            Button(action: {
                print("Floating Button Click");
                self.selection = "All Sites"
            }, label: {
                NavigationLink(destination: SiteListView() , tag: "All Sites", selection: $selection) {
                    Text("All Sites - No Filtering")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Trails Button Click");
                self.selection = "Trails Only"
            }, label: {
                NavigationLink(destination: TrailsView(), tag: "Trails Only", selection: $selection){
                    Text("Trails")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Parks Button Click");
                self.selection = "Parks Only"
            }, label: {
                NavigationLink(destination: ParksView(), tag: "Parks Only", selection: $selection){
                    Text("Parks")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Gym Button Click");
                self.selection = "Gyms Only"
            }, label: {
                NavigationLink(destination: GymView(), tag: "Gyms Only", selection: $selection){
                    Text("Gyms")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Fields Button Click");
                self.selection = "Fields Only"
            }, label: {
                NavigationLink(destination: FieldsView(), tag: "Fields Only", selection: $selection){
                    Text("Courts & Fields")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Pools Button Click");
                self.selection = "Pools Only"
            }, label: {
                NavigationLink(destination: PoolsView(), tag: "Pools Only", selection: $selection){
                    Text("Pools")
                        .fontWeight(.semibold)
                }
            })
            Button(action: {
                print("Classes Button Click");
                self.selection = "Classes Only"
            }, label: {
                NavigationLink(destination: ClassesView(), tag: "Classes Only", selection: $selection){
                    Text("Classes")
                        .fontWeight(.semibold)
                }
            })
        }//vstack
        .navigationBarTitle("Result Filtered", displayMode: .inline)
    }
}

/*struct UserSearch_Previews: PreviewProvider {
    static var previews: some View {
        UserSearch()
    }
}*/
