//
//  Review.swift
//  Recreationalist
//
//  Created by Katrina Curro on 4/23/21.
//

import FirebaseFirestore

class Review: FirebaseCodable, Equatable {
    static func == (lhs: Review, rhs: Review) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String
    @Published var name: String
    @Published var entry: String
    @Published var timestamp: String
    @Published var user_id: String
    @Published var image: String
    @Published var username: String
    
    required init?(id: String, data: [String : Any]) {
        guard let name = data["name"] as? String,
            let user_id = data["user_id"] as? String,
            let timestamp = data["timestamp"] as? String,
            let entry = data["entry"] as? String,
            let image = data["image"] as? String,
            let username = data["username"] as? String
            else{
                return nil
        }
        
        self.id = id
        self.name = name
        self.user_id = user_id
        self.timestamp = timestamp
        self.entry = entry
        self.image = image
        self.username = username
    }
}
