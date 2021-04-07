//
//  Site.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/24/21.
//

import FirebaseFirestore
//import CoreLocation

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
    //@Published var location: CLLocationCoordinate2D
    @Published var trails: Bool
    @Published var parks: Bool
    @Published var fields: Bool
    @Published var gyms: Bool
    @Published var pools: Bool
    @Published var classes: Bool
    //@Published var logo: String


    required init?(id: String, data: [String : Any]) {
        guard let name = data["name"] as? String,
            let city = data["city"] as? String,
            let state = data["state"] as? String,
            let siteDetails = data["siteDetails"] as? String,
            let location = data["location"] as? GeoPoint,
            let trails = data["trails"] as? Bool,
            let parks = data["parks"] as? Bool,
            let fields = data["fields"] as? Bool,
            let gyms = data["gyms"] as? Bool,
            let pools = data["pools"] as? Bool,
            let classes = data["classes"] as? Bool
            //let logo = data["logo"] as? String
            else {
                return nil
            }
        
        self.id = id
        self.name = name
        self.city = city
        self.state = state
        self.location = location
        self.siteDetails = siteDetails
        self.trails = trails
        self.gyms = gyms
        self.parks = parks
        self.fields = fields
        self.pools = pools
        self.classes = classes
        //self.logo = logo
    }
}

