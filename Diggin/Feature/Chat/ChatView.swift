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
            Text("오늘의 음악 추천")
                .font(.suitB(25))
                .padding(.leading, 20)
                .foregroundColor(.white)
            
            Text("DigginBot에게 추천받아보세요!")
                .font(.suitSB(15))
                .padding(.leading, 20)
                .foregroundColor(.gray)
                .padding(.top, 0)
            
            ScrollView {
                contentView
            }
            .background(.black)
            .navigationBarBackButtonHidden()
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
                    Image("search")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .tint(Color.white)
                }
                .padding(.trailing, 20)
                .disabled(viewModel.message.isEmpty)
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
