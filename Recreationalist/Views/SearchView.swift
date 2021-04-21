//
//  SearchView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/17/21.
//

import SwiftUI

struct SearchView: View {
    //@State var editing = false
    //@State var search: String = ""
    //@State private var selection: String? = nil
    //let fetchUserLocation = UserLocation()
        
    var body: some View {
        NavigationView {
            ZStack{
                Image("hiking")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center, spacing:30) {
                    Text("Explore the natural beauty of your local area")
                        //can eventually remove this out keeping for right now
                        .font(.headline)
                        .padding()
                    Button(action: {
                        print("Floating Button Click To Use Current Location");
                        //self.selection = "Users Location"
                        //self.fetchUserLocation.start()
                    }, label: {
                        NavigationLink(destination: UsersSearch()) {
                            Text("Click to Search With Current Location")
                                .font(.system(size:20))
                        }
                    })
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
