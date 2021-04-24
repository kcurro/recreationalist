//
//  CollectionRow.swift
//  Recreationalist
//
//  Created by Katrina Curro on 4/22/21.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct CollectionRow: View {
    @ObservedObject var favorite: Favorite
    @State private var urlImage = URL(string: "")
    
    var body: some View {
        HStack{
            WebImage(url: urlImage)
            //first set it to be resizable so any asset of this type is resizable
                .resizable()
                .frame(width: 125, height: 100)
                //makes rounded edges
                .cornerRadius(10)
            Text(favorite.name)
        }.onAppear(perform: loadImageFromFirebase)
    }
    func loadImageFromFirebase() {
        let storage = Storage.storage().reference(withPath: favorite.logo)
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

/*struct CollectionRow_Previews: PreviewProvider {
    static var previews: some View {
        CollectionRow()
    }
}*/
