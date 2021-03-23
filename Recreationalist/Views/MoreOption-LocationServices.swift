//
//  MoreOption-LocationServices.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 3/22/21.
//

import SwiftUI

struct MoreOption_LocationServices: View {
    //MARK: -PROPERTIES
    
    //MARK: -BODY
    var body: some View {
        NavigationView {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                Form {
                    NavigationLink(destination: Text("Go to settings and change location to never, ask next time, while using app, or always")){
                        MoreRow(firstText: "Location Settings")
                    }
                }//: FORM
                Text("You can let Recreationalist receive your location when you're using the app and while  the app is in the background to search for nearby sites and give you a better local experience. You can adjust your location settings at any time.")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top)
                    .padding(.bottom)
                    .foregroundColor(Color.secondary)
            }//: VSTACK
            .navigationBarTitle("Location Services", displayMode: .inline)
            .background(Color("ColorBackground").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        }//: NAVIGATION
    }
}

//MARK: -PREVIEW
struct MoreOption_LocationServices_Previews: PreviewProvider {
    static var previews: some View {
        MoreOption_LocationServices()
    }
}
