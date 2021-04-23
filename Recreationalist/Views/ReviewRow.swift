//
//  ReviewRow.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/26/21.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct ReviewRow: View {
     @ObservedObject var review: Review
     //to do add firebase storage and images for sites
     @State var urlImage = URL(string: "")
    
     var body: some View {
        VStack{
            HStack{
                WebImage(url: urlImage)
                //first set it to be resizable so any asset of this type is resiazable
                    .resizable()
                    .frame(width: 125, height: 100, alignment: .center)
                    //makes rounded edges
                    .cornerRadius(10)
                Spacer()
                Text("Visted by \(review.username) on \(review.timestamp)")
                    .font(.system(size:10))
            }
        //underneath it we have the entry from the user
            Text(review.entry)
                .font(.system(size:15))
         }.onAppear(perform: loadImageFromFirebase)
     }
    
     func loadImageFromFirebase() {
         //have to go from url to actual cloud storage in order to derive new cloud storage we start with a let to create an instance of the storage object with a path to a url
         let storage = Storage.storage().reference(withPath: review.image)
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
