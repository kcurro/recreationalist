//
//  MoreOption-LogOut.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 3/22/21.
//

import SwiftUI

struct MoreOption_LogOut: View {
    //MARK: -PROPERTIES
    @State private var logOutAlert = false
    @EnvironmentObject var session: FirebaseSession
    
    //MARK: -BODY
    var body: some View {
        /*Button("Log Out") {
            logOutAlert = true
            
        }*/
        
        Button(action: {session.signOut(); logOutAlert=true}, label: {
            Text("Sign Out")
        })
        
        .alert(isPresented: $logOutAlert) { () -> Alert in Alert(title: Text("Okay, you're signed out!"))
        }
        .foregroundColor(Color.black)
        .buttonStyle(SemiboldButtonFont())
    }
}

struct SemiboldButtonFont: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.body.weight(.semibold))
    }
}

//MARK: -PREVIEW
struct MoreOption_LogOut_Previews: PreviewProvider {
    static var previews: some View {
        MoreOption_LogOut()
            .previewLayout(.fixed(width:375, height:60))
            .padding()
            .environmentObject(FirebaseSession.shared)
    }
}
