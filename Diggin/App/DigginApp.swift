//
//  DigginApp.swift
//  Diggin
//
//  Created by 김승찬 on 2023/11/30.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct DigginApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "appStart") {
                CustomTabBarView()
            } else {
                OnboardingView()
            }
        }
    }
}
