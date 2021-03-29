//
//  MoreOption-ClearHistory.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 3/22/21.
//

import SwiftUI

struct MoreOption_ClearHistory: View {
    // MARK: -PROPERTIES
    @State private var clearHistoryAlert = false
    
    // MARK: -BODY
    var body: some View {
        Button("Clear History"){
                  clearHistoryAlert = true
              }
              .alert(isPresented: $clearHistoryAlert) { () -> Alert in
                let primaryButton = Alert.Button.default(Text("No")) {
                print("primary button pressed")
              }
                let secondaryButton = Alert.Button.default(Text("Yes")) {
                    print("secondary button pressed")
                }
                return Alert(title: Text("Clear your keyword, location and recent history?"), primaryButton: primaryButton, secondaryButton: secondaryButton)
              }
        .foregroundColor(Color.black)
        .buttonStyle(SemiboldButtonFont())
    }
}

//MARK: -PREVIEW

struct MoreOption_ClearHistory_Previews: PreviewProvider {
    static var previews: some View {
        MoreOption_ClearHistory()
            .previewLayout(.fixed(width:375, height:60))
            .padding()
    }
}
