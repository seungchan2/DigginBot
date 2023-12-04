//
//  ChatViewModel.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/04.
//

import Combine
import Foundation

import ChatGPTSwift
import RealmSwift

final class ChatViewModel: ObservableObject {
    
    enum Action {
        case load
        case addChat(message: String)
    }
    
    @Published var chatDataList: [ChatData] = [ChatData(dateStr: "오늘",
                                                        chats: [Chat(message: "오늘 들을 음악은?",
                                                                     date: Date(),
                                                                     direction: .left)])]
    
    @Published var message: String = ""
    private var subscription = Set<AnyCancellable>()
    private lazy var api = Config.apiKey
    private lazy var gptRequest = ChatGPTAPI(apiKey: api)
    private var repository: ChatDBRepositoryType
    
    init(repository: ChatDBRepositoryType) {
        self.repository = repository
        bind()
    }
    
    private func bind() {
        repository.observeChat()
            .sink { [weak self] chatObjects in
                guard let self else { return }
                
                let chats = chatObjects.map { chatObject in
                    if chatObject.direction {
                        return Chat(message: chatObject.message, date: chatObject.date, direction: .left)
                    } else {
                        return Chat(message: chatObject.message, date: chatObject.date, direction: .right)
                    }
                }
                
                let groupedChats = Dictionary(grouping: chats) { chat in
                    return self.formatDate(chat.date)
                }
                
                let chatDataList = groupedChats.map { dateStr, chats in
                    return ChatData(dateStr: dateStr, chats: chats)
                }
                
                self.chatDataList = chatDataList
            }
            .store(in: &subscription)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: date)
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            print("load")
        case let .addChat(message):
            addChatToRepository(message: message, direction: .right)
            getGPTAnswer(message: message)
        }
    }
    
    private func addChatToRepository(message: String, direction: ChatItemDirection) {
        let chat: Chat = .init(message: message, date: Date(), direction: direction)
        let chatObject = ChatObject(message: chat.message!, date: chat.date, direction: direction == .right ? false : true)
        
        repository.addChat(chatObject)
            .sink { completion in
            } receiveValue: { [weak self] _ in
                self?.message = ""
            }
            .store(in: &subscription)
    }
    
    private func getGPTAnswer(message: String) {
        Task {
            do {
                let response = try await gptRequest.sendMessage(text: message)
                DispatchQueue.main.async {
                    self.addChatToRepository(message: response, direction: .left)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
