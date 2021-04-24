//
//  Profile.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 4/23/21.
//

import FirebaseFirestore

class Profile: FirebaseCodable, Equatable {
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String
    @Published var userID: String
    @Published var fullName: String
    @Published var gender: String
    @Published var profileImage: String

    required init?(id: String, data: [String : Any]) {
        guard let userID = data["userID"] as? String,
            let fullName = data["full_name"] as? String,
            let gender = data["gender"] as? String,
            let profileImage = data["profile_image"] as? String
            else {
                return nil
            }
        
        self.id = id
        self.userID = userID
        self.fullName = fullName
        self.gender = gender
        self.profileImage = profileImage
    }
}
