//
//  ContentView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/4/21.
//

import SwiftUI
import FirebaseFirestore


struct ContentView: View {
    //Firestore.firestore() to connect db
    let db = Firestore.firestore()

    var body: some View {
        Text("Recreationalist")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
