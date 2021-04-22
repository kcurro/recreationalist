//
//  Favorite.swift
//  Recreationalist
//
//  Created by Katrina Curro on 4/22/21.
//

import FirebaseFirestore

class Favorite: FirebaseCodable, Equatable {
    static func == (lhs: Favorite, rhs: Favorite) -> Bool {
        return lhs.id == rhs.id
    }
    var id: String
    @Published var name: String
    @Published var city: String
    @Published var state: String
    @Published var siteDetails: String
    @Published var location: GeoPoint
    @Published var logo: String
    @Published var user_id: String
    
    required init?(id: String, data: [String : Any]) {
        guard let name = data["name"] as? String,
            let city = data["city"] as? String,
            let state = data["state"] as? String,
            let siteDetails = data["siteDetails"] as? String,
            let location = data["location"] as? GeoPoint,
            let logo = data["logo"] as? String,
            let user_id = data["user_id"] as? String
            else {
                return nil
            }
        
        self.id = id
        self.name = name
        self.city = city
        self.state = state
        self.location = location
        self.siteDetails = siteDetails
        self.logo = logo
        self.user_id = user_id
    }
}
