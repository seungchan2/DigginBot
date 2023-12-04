//
//  TabViewModel.swift
//  Diggin
//
//  Created by 김승찬 on 2023/11/30.
//

import Foundation

class TabViewModel: ObservableObject {
    @Published var selectedTab: Tab
    
    init(
        selectedTab: Tab = .gpt
    ) {
        self.selectedTab = selectedTab
    }
}
