//
//  InfoView.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/05.
//

import SwiftUI

enum tapInfo : String, CaseIterable {
    case recommend = "추천"
    case list = "보관함"
}

struct CustomTabBarView: View {
    @State private var selectedPicker: tapInfo = .recommend
    @Namespace private var animation
    
    var body: some View {
        NavigationView {
            VStack {
                animate()
                MakeTopTabBar(tap: selectedPicker, viewModel: ChatViewModel(repository: ChatDBRepository()))
            }
            .background(Color.blackSub.edgesIgnoringSafeArea(.all))
        }
    }
    
    @ViewBuilder
    private func animate() -> some View {
        HStack {
            ForEach(tapInfo.allCases, id: \.self) { item in
                VStack {
                    Text(item.rawValue)
                        .font(.suitB(20))
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity / 4, minHeight: 50)
                        .foregroundColor(selectedPicker == item ? .white : .gray)
                    
                    if selectedPicker == item {
                        Capsule()
                            .foregroundColor(.white)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "diggin", in: animation)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedPicker = item
                    }
                }
            }
        }
    }
}

struct MakeTopTabBar: View {
    
    var tap: tapInfo
    
    @StateObject var viewModel: ChatViewModel
    @FocusState var isFocused: Bool
    
    var body: some View {
        switch tap {
        case .recommend:
            VStack {
                ChatView(viewModel: viewModel)
            }
            .keyboardToolbar(height: 50) {
                HStack {
                    TextField("", text: $viewModel.message)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .focused($isFocused)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 10)
                        .background(Color.black)
                        .cornerRadius(10)
                        .padding(.leading, 20)
                    
                    Button {
                        viewModel.send(action: .addChat(message: viewModel.message))
                        isFocused = false
                    } label: {
                        Image("paper-plane")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .tint(Color.white)
                    }
                    .padding(.trailing, 20)
                    .disabled(viewModel.message.isEmpty)
                }
            }
            .background(Color.blackSub)
            
        case .list:
            ZStack {
                MusicListView(viewModel: MusicListViewModel(repository: WriteDBRepository()))
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: WriteView(viewModel: WriteViewModel(repository: WriteDBRepository(), photoService: PhotoPickerService()))) {
                            Image(systemName: "plus")
                                .renderingMode(.template)
                                .foregroundColor(Color.stemGreen)
                                .frame(width: 28, height: 28)
                                .padding()
                        }
                        .background(Color.gray)
                        .foregroundColor(Color.stemGreen)
                        .clipShape(Circle())
                        .padding()
                    }
                }
            }
        }
    }
}
