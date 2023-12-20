//
//  OnboardingView.swift
//  Diggin
//
//  Created by 김승찬 on 2023/11/30.
//

import SwiftUI

import FirebaseAnalytics

struct OnboardingView: View {
    @StateObject private var pathModel = PathModel()
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    
    var body: some View {
        NavigationStack(path: $pathModel.paths) {
            OnboardingContentView(onboardingViewModel: onboardingViewModel)
                .navigationDestination(
                    for: PathType.self) { pathType in
                        switch pathType {
                        case .main:
                            CustomTabBarView()                                   .navigationBarBackButtonHidden()
                        }
                    }
        }
        .environmentObject(pathModel)
    }
}

private struct OnboardingContentView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    
    fileprivate init(onboardingViewModel: OnboardingViewModel) {
        self.onboardingViewModel = onboardingViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            OnboardingCellListView(onboardingViewModel: onboardingViewModel)
            Spacer()
            StartButtonView()
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color.blackSub)
    }
}

private struct OnboardingCellListView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    @State private var selectedIndex: Int
    
    fileprivate init(
        onboardingViewModel: OnboardingViewModel,
        selectedIndex: Int = 0
    ) {
        self.onboardingViewModel = onboardingViewModel
        self.selectedIndex = selectedIndex
    }
    
    fileprivate var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(Array(onboardingViewModel.onboardingContent.enumerated()), id:  \.element) { index, onboardingContent in
                OnboardingCellView(onboardingContent: onboardingContent)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.3)
        .background(Color.stemGreen)
    }
}

private struct OnboardingCellView: View {
    private var onboardingContent: OnboardingContent
    
    fileprivate init(onboardingContent: OnboardingContent) {
        self.onboardingContent = onboardingContent
    }
    
    fileprivate var body: some View {
        VStack {
            Image(onboardingContent.imageFileName)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 10)
        }
    }
}

private struct StartButtonView: View {
    @EnvironmentObject private var pathModel: PathModel
    fileprivate var body: some View {
        Button(
            action: {
                UserDefaults.standard.set(true, forKey: "appStart")
                pathModel.paths.append(.main)
                let event = "startDiggin"
                Analytics.logEvent(event, parameters: nil)
            },
            label:  {
                HStack {
                    Text("시작하기")
                        .font(.suitB(18))
                        .foregroundColor(.white)
                }
            })
        .padding(.bottom, 50)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
