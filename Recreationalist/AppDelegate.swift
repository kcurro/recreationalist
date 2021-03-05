//
//  AppDelegate.swift
//  Recreationalist
//
//  Created by Katrina Curro on 3/4/21.
//


import UIKit
import Firebase

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
