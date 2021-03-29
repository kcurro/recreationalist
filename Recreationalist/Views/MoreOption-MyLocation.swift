//
//  MoreOption-MyLocation.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 3/25/21.
//

import SwiftUI

struct MoreOption_MyLocation: View {
    //MARK: -PROPERTIES
    @State var location: String = ""
    
    //MARK: -BODY
    var body: some View {
        //MARK: -NAVIGATION VIEW
        NavigationView{
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing:0){
                Form{
                    TextField("Primary Location", text: $location)
                }
            }//: VSTACK
            .navigationBarTitle("My Location", displayMode: .inline)
            .background(Color("ColorBackground").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        }//: NAVIGATION VIEW
    }
}

//MARK: -PREVIEW
struct MoreOption_MyLocation_Previews: PreviewProvider {
    static var previews: some View {
        MoreOption_MyLocation()
    }
}
