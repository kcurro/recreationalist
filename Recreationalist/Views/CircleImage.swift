//
//  CircleImage.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 3/29/21.
//

import SwiftUI

struct CircleImage: View {
    //MARK: -PROPERTIES
    var image: Image
    
    //MARK: -BODY
    var body: some View {
        image
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius:7)
            .frame(width:95, height:95)
    }
}

//MARK: -PREVIEW
struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("roronoazoro").resizable())
    }
}
