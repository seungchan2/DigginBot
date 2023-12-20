//
//  OnboardingContent.swift
//  Diggin
//
//  Created by 김승찬 on 2023/11/30.
//

import Foundation

struct OnboardingContent: Hashable {
    var imageFileName: String
    
    init(
        imageFileName: String
    ) {
        self.imageFileName = imageFileName
    }
}
