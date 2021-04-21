//
//  ProfileView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/17/21.
//

import SwiftUI

struct ProfileView: View {
    //MARK: -PROPERTIES
    @EnvironmentObject var session: FirebaseSession
    
    //MARK: -BODY
    @ViewBuilder
    var body: some View {
    //@ViewBuilder //this is throwing errors for me - follow up with kim
        if session.loggedInUser != nil {
            ProfileView_SignedInView()
        } else {
            ProfileView_AuthenticationView(authType: .signin) //if forget to sign out and crashed comment out this line and line in More View
        }
    }
}

//MARK: -PREVIEW
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(FirebaseSession.shared)
    }
}
