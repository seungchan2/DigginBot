//
//  HomeTabView.swift
//  Diggin
//
//  Created by 김승찬 on 2023/11/30.
//

import SwiftUI
//
//struct HomeTabView: View {
//    @EnvironmentObject private var pathModel: PathModel
//    @StateObject private var viewModel = TabViewModel()
//    @State private var selectedTab: Tab
//
//    init(selectedTab: Tab) {
//           _selectedTab = State(initialValue: selectedTab)
//    }
//    
//    var body: some View {
//        ZStack {
//            TabView(selection: $viewModel.selectedTab) {
//                ChatView(viewModel: ChatViewModel(repository: ChatDBRepository()))
//                    .tabItem {
//                        Image(systemName: "heart.fill")
//                        Text("GPT")
//                    }
//                    .tag(Tab.gpt)
//                
//                MusicListView()
//                    .tabItem {
//                        Image(systemName: "heart.fill")
//                        Text("Music")
//                    }
//                    .tag(Tab.music)
//                
//                MyPageView()
//                    .tabItem {
//                       Image(systemName: "heart.fill")
//                       Text("MyPage")
//                    }
//                    .tag(Tab.myPage)
//            }
//        }
//    }
//}
//
//
//struct HomeTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeTabView(selectedTab: .gpt)
//            .environmentObject(PathModel())
//            .environmentObject(TabViewModel())
//    }
//}
