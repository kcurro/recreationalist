//
//  SearchView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/17/21.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Image("hiking")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center, spacing:30) {
                    Text("Explore the natural beauty of your local area")
                        .font(.headline)
                        .padding()
                    Button(action: {
                        print("Floating Button Click To Use Current Location");
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
