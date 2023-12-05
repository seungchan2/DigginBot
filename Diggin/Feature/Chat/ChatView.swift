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
            
            Text("DigginBot에게 추천받아보세요!")
                .font(.suitB(17))
                .padding(.leading, 20)
                .foregroundColor(.gray)
            
            ScrollView {
                contentView
            }
            .background(.black)
            .navigationBarBackButtonHidden()
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
    
    func headerView(dateStr: String) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .background(Color.black)
                .cornerRadius(10)
            Text(dateStr)
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
