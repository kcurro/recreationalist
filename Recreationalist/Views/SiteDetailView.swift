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

    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text(site.name)
                    .font(.largeTitle)

                HStack {
                    Text("\(site.city), \(site.state)")
                }
                
                Text("Details")
                    .font(.largeTitle)
            
                HStack {
                    Text(site.siteDetails)
                    Spacer()
                }
            
                Text("Reviews")
                    .font(.largeTitle)
                Spacer()
            }
        } .padding()
    }
}

/*struct SiteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SiteDetailView()
    }
}*/
