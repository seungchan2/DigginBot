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
        .init(imageFileName: "heart.fill", title: "오늘의 할일", subTitle: "오에오~~에오에오~~에오에오~~에오에오~~에오에오~~에오에오~~에오에오~~에오에오~~에오에오~~에"),
        .init(imageFileName: "heart.fill", title: "오늘의 할일", subTitle: "11"),
        .init(imageFileName: "heart.fill", title: "오늘의 할일", subTitle: "11")
    ]
    ) {
        self.onboardingContent = onboardingContent
    }
}
