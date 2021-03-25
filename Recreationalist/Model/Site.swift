//
//  Site.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/24/21.
//

import FirebaseFirestore

class Site: FirebaseCodable, Equatable {
    static func == (lhs: Site, rhs: Site) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String
    @Published var name: String
    @Published var city: String
    @Published var state: String
    @Published var siteDetails: String
    @Published var location: GeoPoint
    @Published var activity1: String
    @Published var activity2: String
    @Published var activity3: String

    required init?(id: String, data: [String : Any]) {
        guard let name = data["name"] as? String,
            let city = data["city"] as? String,
            let state = data["state"] as? String,
            let siteDetails = data["siteDetails"] as? String,
            let location = data["location"] as? GeoPoint,
            let activity1 = data["activity1"] as? String,
            let activity2 = data["activity2"] as? String,
            let activity3 = data["activity3"] as? String
            else {
                return nil
            }
        
        self.id = id
        self.name = name
        self.city = city
        self.state = state
        self.location = location
        self.siteDetails = siteDetails
        self.activity1 = activity1
        self.activity2 = activity2
        self.activity3 = activity3

    }
    
}
