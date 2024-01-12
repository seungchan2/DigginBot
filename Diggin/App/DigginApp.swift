//
//  DigginApp.swift
//  Diggin
//
//  Created by 김승찬 on 2023/11/30.
//

import SwiftUI
import UIKit
import UserNotifications

import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("알림 권한이 허용되었습니다.")
            } else {
                print("알림 권한이 거부되었습니다.")
            }
        }
        UNUserNotificationCenter.current().delegate = self
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
