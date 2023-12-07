//
//  ChatView.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/04.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("DigginBot에게 음악 추천 받아보세요!")
                .font(.suitB(17))
                .padding(.leading, 20)
                .padding(.top, 10)
                .foregroundColor(.gray)
            
            if viewModel.chatDataList.isEmpty {
                ScrollView {
                    VStack(alignment: .center) {
                        emptyView
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            } else {
                ScrollView {
                    contentView
                }
                .background(.black)
                .navigationBarBackButtonHidden()
            }
            
        }
        .background(Color.blackSub)
    }
    
    var contentView: some View {
        ForEach(viewModel.chatDataList) { chatData in
            Section {
                ForEach(chatData.chats) { chat in
                    ChatItemView(message: chat.message ?? "", direction: chat.direction, date: chat.date)
                }
            } header: {
                headerView(dateStr: chatData.dateStr)
            }
        }
    }
    
    var emptyView: some View {
        Text("현재는 비어있어요 ㅠ.ㅠ")
            .foregroundColor(.white)
    }
    
    func headerView(dateStr: String) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .background(Color.black)
                .cornerRadius(10)
            Text(dateStr)
                .padding(.top, 10)
                .font(.suitB(15))
                .foregroundColor(Color.white)
        }
    }
}


struct ChatItemView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: ChatViewModel(repository: ChatDBRepository()))
    }
}
