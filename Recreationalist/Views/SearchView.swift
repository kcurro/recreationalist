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
                VStack(alignment: .center, spacing: 20) {
                    //added this to see
                    LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                                   startPoint: .leading,
                                   endPoint: .trailing)
                        .mask(Text("Recreationalist")
                                .font(.system(size: 40, weight: .heavy)))
                    //added this to see
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
                } .padding(.bottom, 500.0)
                //.navigationBarTitle("Recreationalist")
            }
        }
    }
}

/*struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}*/
