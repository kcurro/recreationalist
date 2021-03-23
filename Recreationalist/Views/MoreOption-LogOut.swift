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
    
    //MARK: -BODY
    var body: some View {
        Button("Log Out") {
            logOutAlert = true 
        }
        .alert(isPresented: $logOutAlert) { () -> Alert in Alert(title: Text("Okay, you're logged out!"))
        }
        .foregroundColor(Color.gray)
    }
}

//MARK: -PREVIEW
struct MoreOption_LogOut_Previews: PreviewProvider {
    static var previews: some View {
        MoreOption_LogOut()
    }
}
