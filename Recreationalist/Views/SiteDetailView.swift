//
//  SiteDetailView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/24/21.
//

import SwiftUI
import FirebaseFirestore

struct SiteDetailView: View {
    @ObservedObject var site: Site

    /*init(site: Site) {
        self.site = site
    }*/

    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text(site.city)
                Text(site.state)
                Spacer()
            }
            Text("Details")
                .font(.largeTitle)
            HStack{
                Text(site.siteDetails)
                Spacer()
            }
            Text("Reviews")
                .font(.largeTitle)
            Spacer()
        }
        .padding()
        .navigationBarTitle(site.name)
    }
}

/*struct SiteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SiteDetailView()
    }
}*/
