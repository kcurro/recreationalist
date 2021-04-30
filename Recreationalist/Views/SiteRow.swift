//
//  SiteRow.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/24/21.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct SiteRow: View {
    @ObservedObject var site: Site
    @State private var urlImage = URL(string: "")
    
    var body: some View {
        HStack{
            WebImage(url: urlImage)
                //first set it to be resizable so any asset of this type is resizable
                .resizable()
                .frame(width: 125, height: 100)
                //makes rounded edges
                .cornerRadius(10)
            Text(site.name)
        }.onAppear(perform: loadImageFromFirebase)
    }
    func loadImageFromFirebase() {
        //have to go from url to actual cloud storage in order to derive new cloud storage we start with a let to create an instance of the storage object with a path to a url
        let storage = Storage.storage().reference(withPath: site.logo)
        //once we have the actual path then we have to do download from storage with a lambda. taking in url and error as parameters then we first do an error check
        storage.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            //last step we set the image url
            self.urlImage = url!
        }
    }
}

/*struct SiteRow_Previews: PreviewProvider {
    static var previews: some View {
        SiteRow(site: Site.example)
    }
}*/
