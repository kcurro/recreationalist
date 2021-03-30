//
//  ProfileView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/17/21.
//

import SwiftUI

struct ProfileView: View {
    //MARK: -PROPERTIES
    private var data = ["186,467\nACTIVITES","0\nREVIEWS"]
    private var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    //MARK: -BODY
    var body: some View {
        //MARK: -NAVIGATION VIEW
        NavigationView{
            //MARK: -HSTACK
            HStack{
                CircleImage(image:Image("roronoazoro").resizable())
                //MARK: -VSTACK
                VStack(alignment:.leading){
                    Text("Zoro Roronoa")
                        .font(.title2)
                        .fontWeight(.semibold)
                    LazyVGrid(columns: threeColumnGrid) {
                     ForEach(data, id: \.self){
                        item in Text(item).font(.caption)
                     }
                    }
                }//: VSTACK
                }//:HSTACK
            .offset(y: -410)
            .padding(.bottom, -120)
            .padding(.horizontal, 20)
        }//: NAVIGATION VIEW
    }
}

//MARK: -PREVIEW
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
