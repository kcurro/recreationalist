//
//  MoreOption-LinkedAccounts.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 3/28/21.
//

import SwiftUI

struct MoreOption_LinkedAccounts: View {
    //MARK: -PROPERTIES
    @State private var status1 = false
    @State private var status2 = false
    @State private var status3 = false
    
    //MARK: -BODY
    var body: some View {
        //MARK: -NAVIGATION VIEW
        NavigationView{
            //MARK: -VSTACK
            VStack(alignment: .center, spacing: 0){
                Form{
                    Section(header:Text("Connect with external applications:"))
                    {
                        Toggle(isOn: $status1){
                            Text("Google")
                                .fontWeight(.semibold)
                        }.toggleStyle(SwitchToggleStyle(tint:Color.purple))
                        Toggle(isOn: $status2){
                            Text("Facebook")
                                .fontWeight(.semibold)
                        }.toggleStyle(SwitchToggleStyle(tint:Color.purple))
                        Toggle(isOn: $status3){
                            Text("Apple")
                                .fontWeight(.semibold)
                        }.toggleStyle(SwitchToggleStyle(tint:Color.purple))
                    }
                }
            }//: VSTACK
            .navigationBarTitle("Linked Accounts", displayMode: .inline)
            .background(Color("ColorBackground").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        }//: NAVIGATION VIEW
    }
}

//MARK: -PREVIEW
struct MoreOption_LinkedAccounts_Previews: PreviewProvider {
    static var previews: some View {
        MoreOption_LinkedAccounts()
    }
}
