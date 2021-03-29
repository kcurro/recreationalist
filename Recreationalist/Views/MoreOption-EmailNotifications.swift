//
//  MoreOption-EmailNotifications.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 3/29/21.
//

import SwiftUI

struct MoreOption_EmailNotifications: View {
    //MARK: -PROPERTIES
    @State private var status1 = false
    
    //MARK: -BODY
    var body: some View {
        //MARK: -NAVIGATION VIEW
        NavigationView{
            //MARK: -VSTACK
            VStack(alignment: .center, spacing: 0){
                Form{
                    Section(footer:Text("Note: You will still receive certain legal, transactional or administrative emails."))
                    {
                        Toggle(isOn: $status1){
                            Text("Receive emails from Recreationalist")
                                .fontWeight(.semibold)
                        }.toggleStyle(SwitchToggleStyle(tint:Color.yellow))
                    }
                }
            }//: VSTACK
            .navigationBarTitle("Email Notifications", displayMode: .inline)
            .background(Color("ColorBackground").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        }//: NAVIGATION VIEW
    }
}

struct MoreOption_EmailNotifications_Previews: PreviewProvider {
    static var previews: some View {
        MoreOption_EmailNotifications()
    }
}
