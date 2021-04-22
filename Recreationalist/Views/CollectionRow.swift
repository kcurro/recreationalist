//
//  CollectionRow.swift
//  Recreationalist
//
//  Created by Katrina Curro on 4/22/21.
//

import SwiftUI

struct CollectionRow: View {
    @ObservedObject var favorite: Favorite
    //to do add firebase storage and images for sites
    
    var body: some View {
        HStack{
            Text(favorite.name)
        }
    }
}

/*struct CollectionRow_Previews: PreviewProvider {
    static var previews: some View {
        CollectionRow()
    }
}*/
