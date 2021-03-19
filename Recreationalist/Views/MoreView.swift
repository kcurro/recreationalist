//
//  MoreView.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 3/18/21.
//

import SwiftUI

struct MoreView: View {
    // MARK: - PROPERTIES
    var moreOptions: [String] = ["Email Notifications", "Push Notifications", "Linked Accounts", "Privacy Settings", "My Locations", "Location Services", "Clear History", "Log Out"]
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0)  {
                // MARK: - FORM
                Form{
                    // MARK: - SECTION 4
                    Section(header: Text("Application Settings")) {
                        
                        ForEach(moreOptions, id: \.self) {
                            o in NavigationLink(destination: Text(o)){
                                MoreRow(firstText: o)
                            }
                        }
                    } //:SECTION 4
                    .padding(.vertical, 3)
                }//: FORM
                
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                // MARK: - FOOTER
                Text("Terms of Service, Privacy Policy\nCopyright © 2021 \nRecreationalist Version 1.0.0 ")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top,6)
                    .padding(.bottom,8)
                    .foregroundColor(Color.secondary)
            }//: VSTACK
            .navigationBarTitle("More", displayMode: .inline)
            .background(Color("ColorBackground").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        }//: NAVIGATION
    }
}

// MARK:  - PREVIEW

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
