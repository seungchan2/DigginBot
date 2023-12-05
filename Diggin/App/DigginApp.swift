//
//  DigginApp.swift
//  Diggin
//
//  Created by 김승찬 on 2023/11/30.
//

import SwiftUI

@main
struct DigginApp: App {
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
