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
                    Section(footer:Text("You can let Recreationalist receive your location when you're using the app and while  the app is in the background to search for nearby sites and give you a better local experience. You can adjust your location settings at any time.")){
                        NavigationLink(destination:Text("Open Settings")){
                            MoreRow(firstText: "Location Settings")
                        }
                    }
                }//: FORM
            }.navigationBarTitle("Location Services", displayMode: .inline)
            .background(Color("ColorBackground").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        }//: VSTACK
    }//: NAVIGATION VIEW
}

//MARK: -PREVIEW
struct MoreOption_LocationServices_Previews: PreviewProvider {
    static var previews: some View {
        MoreOption_LocationServices()
    }
}
