//
//  FirebaseCollection.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/24/21.
//

import FirebaseFirestore

protocol FirebaseCodable: Identifiable, ObservableObject {
    init?(id: String, data: [String: Any])
}

class FirebaseCollection<T: FirebaseCodable>: ObservableObject {
    @Published private(set) var items: [T]
    //allows us to run queries against our database ex this can work for user queries aka find username when signing in - this is crucial for making the query work
    init(query: Query) {
        self.items = []
        listenForChanges(query: query)
    }
    
    private func listenForChanges(query: Query) {
        query.addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            let models = snapshot.documents.map { (document) -> T in
                if let model = T(id: document.documentID,
                                 data: document.data()) {
                    return model
                } else {
                    fatalError("Unable to initialize type \(T.self) with dictionary \(document.data())")
                }
            }
            self.items = models
        }
    }
}
