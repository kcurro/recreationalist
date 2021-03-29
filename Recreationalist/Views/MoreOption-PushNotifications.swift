//
//  MoreOption-PushNotifications.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 3/28/21.
//

import SwiftUI

struct MoreOption_PushNotifications: View {
    //MARK: -PROPERTIES
    @State private var status1 = false
    @State private var status2 = false
    
    //MARK: -BODY
    var body: some View {
        //MARK: -NAVIGATION VIEW
        NavigationView{
            //MARK: -VSTACK
            VStack(alignment: .center, spacing: 0){
                Form{
                    Section(header:Text("Reactions to your posts"))
                    {
                        Toggle(isOn: $status1){
                            Text("Photo and video likes")
                                .fontWeight(.semibold)
                        }.toggleStyle(SwitchToggleStyle(tint:Color.yellow))
                        Toggle(isOn: $status2){
                            Text("Review comments")
                                .fontWeight(.semibold)
                        }.toggleStyle(SwitchToggleStyle(tint:Color.yellow))
                    }
                }
            }//: VSTACK
            .navigationBarTitle("Push Notifications", displayMode: .inline)
            .background(Color("ColorBackground").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        }//: NAVIGATION VIEW
    }
}

//MARK: -PREVIEW
struct MoreOption_PushNotifications_Previews: PreviewProvider {
    static var previews: some View {
        MoreOption_PushNotifications()
    }
}
