//
//  MoreView.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 3/18/21.
//

import SwiftUI

//MARK: -MORE VIEW
struct MoreView: View {
    //MARK: -PROPERTIES
    @EnvironmentObject var session: FirebaseSession
    
    //MARK: -BODY
    @ViewBuilder
    var body: some View {
        if session.isSignedIn {
            MoreSignedInView()
        } else {
            MoreSignedOutView() //if forget to sign out  and crashed comment out this line and line in Profile View
        }
    }
}

struct MoreSignedInView: View {
    // MARK: - PROPERTIES
    //@EnvironmentObject var session: FirebaseSession
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0)  {
                // MARK: - FORM
                Form{
                    // MARK: - SECTION 4
                    Section(header: Text("Application Settings")) {
                        NavigationLink(destination: MoreOption_EmailNotifications()){
                            Text("Email Notifications")
                                .fontWeight(.semibold)
                        }
                        NavigationLink(destination: MoreOption_PushNotifications()){
                            Text("Push Notifications")
                                .fontWeight(.semibold)
                        }
                        NavigationLink(destination: MoreOption_LinkedAccounts()){
                            Text("Linked Accounts")
                                .fontWeight(.semibold)
                        }
                        NavigationLink(destination: MoreOption_PrivacySettings()){
                            Text("Privacy Settings")
                                .fontWeight(.semibold)
                        }
                        NavigationLink(destination: MoreOption_MyLocation()){
                            Text("My Location")
                                .fontWeight(.semibold)
                        }
                        NavigationLink(destination: MoreOption_LocationServices()){
                            MoreRow(firstText: "Location Services")
                        }
                        MoreOption_ClearHistory()
                        MoreOption_LogOut()
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

struct MoreSignedOutView: View {
    // MARK: - PROPERTIES
    //@EnvironmentObject var session: FirebaseSession
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0)  {
                // MARK: - FORM
                Form{
                    // MARK: - SECTION 4
                    Section(header: Text("Application Settings")) {
                        NavigationLink(destination: MoreOption_PushNotifications()){
                            Text("Push Notifications")
                                .fontWeight(.semibold)
                        }
                        NavigationLink(destination: MoreOption_MyLocation()){
                            Text("My Location")
                                .fontWeight(.semibold)
                        }
                        NavigationLink(destination: MoreOption_LocationServices()){
                            MoreRow(firstText: "Location Services")
                        }
                        NavigationLink(destination: ProfileView()){
                            MoreRow(firstText: "Sign In")
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

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView().environmentObject(FirebaseSession())
    }
}

/*//MARK: -MORE VIEW
struct MoreView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var session: FirebaseSession
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0)  {
                // MARK: - FORM
                Form{
                    // MARK: - SECTION 4
                    Section(header: Text("Application Settings")) {
                        NavigationLink(destination: MoreOption_EmailNotifications()){
                            Text("Email Notifications")
                                .fontWeight(.semibold)
                        }
                        NavigationLink(destination: MoreOption_PushNotifications()){
                            Text("Push Notifications")
                                .fontWeight(.semibold)
                        }
                        NavigationLink(destination: MoreOption_LinkedAccounts()){
                            Text("Linked Accounts")
                                .fontWeight(.semibold)
                        }
                        NavigationLink(destination: MoreOption_PrivacySettings()){
                            Text("Privacy Settings")
                                .fontWeight(.semibold)
                        }
                        NavigationLink(destination: MoreOption_MyLocation()){
                            Text("My Location")
                                .fontWeight(.semibold)
                        }
                        NavigationLink(destination: MoreOption_LocationServices()){
                            MoreRow(firstText: "Location Services")
                        }
                        MoreOption_ClearHistory()
                        MoreOption_LogOut()
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

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}*/
