//
//  SiteRow.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/24/21.
//

import SwiftUI

struct SiteRow: View {
    @ObservedObject var site: Site
    //to do add firebase storage and images for sites
    
    var body: some View {
        HStack{
            Text(site.name)
        }
    }
}

/*struct SiteRow_Previews: PreviewProvider {
    static var previews: some View {
        SiteRow(site: Site.example)
    }
}*/
