//
//  Font.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/04.
//

import Foundation
import SwiftUI

extension Font {
    static func suitB(_ size: CGFloat) -> Font {
        if let customFont = UIFont(name: DigginFont.bold.rawValue, size: size) {
            return Font(customFont)
        } else {
            return Font.system(size: size, weight: .bold)
        }
    }
    
    static func suitSB(_ size: CGFloat) -> Font {
        if let customFont = UIFont(name: DigginFont.semibold.rawValue, size: size) {
            return Font(customFont)
        } else {
            return Font.system(size: size, weight: .bold)
        }
    }
    
    static func suitM(_ size: CGFloat) -> Font {
        if let customFont = UIFont(name: DigginFont.medium.rawValue, size: size) {
            return Font(customFont)
        } else {
            return Font.system(size: size, weight: .bold)
        }
    }
}


enum DigginFont: String, CaseIterable {
    case bold = "SUIT-Bold"
    case extraBold = "SUIT-ExtraBold"
    case extraLight = "SUIT-ExtraLight"
    case light = "SUIT-Light"
    case heavy = "SUIT-Heavy"
    case medium = "SUIT-Medium"
    case regular = "SUIT-Regular"
    case semibold = "SUIT-SemiBold"
    case thin = "SUIT-Thin"
}
