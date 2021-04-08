//
//  RecreationalistApp.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/4/21.
//

import SwiftUI

@main
struct RecreationalistApp: App {
    //need this line to make firebase work and make firebase connect to app
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            TabBar()
                .environmentObject(AppState())
                .environmentObject(FirebaseSession())
        }
    }
}
