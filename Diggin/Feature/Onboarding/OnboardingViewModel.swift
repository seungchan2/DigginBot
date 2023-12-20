//
//  OnboardingViewModel.swift
//  Diggin
//
//  Created by 김승찬 on 2023/11/30.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var onboardingContent: [OnboardingContent]
    
    init(
    onboardingContent: [OnboardingContent] = [
        .init(imageFileName: "onboardingFirst"),
        .init(imageFileName: "onboardingSecond"),
        .init(imageFileName: "onboardingThird")
    ]
    ) {
        self.onboardingContent = onboardingContent
    }
}
