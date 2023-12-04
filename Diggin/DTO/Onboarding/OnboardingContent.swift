//
//  OnboardingContent.swift
//  Diggin
//
//  Created by 김승찬 on 2023/11/30.
//

import Foundation

struct OnboardingContent: Hashable {
    var imageFileName: String
    var title: String
    var subTitle: String
    
    init(
        imageFileName: String,
        title: String,
        subTitle: String
    ) {
        self.imageFileName = imageFileName
        self.title = title
        self.subTitle = subTitle
    }
}
