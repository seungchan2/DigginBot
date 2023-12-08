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
    
    @Published var chatDataList: [ChatData] = []
    
    @Published var message: String = ""
    private var subscription = Set<AnyCancellable>()
    private lazy var api = Config.apiKey
    private lazy var gptRequest = ChatGPTAPI(apiKey: api)
    private var repository: ChatDBRepositoryType
    
    init(repository: ChatDBRepositoryType) {
        self.repository = repository
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            self.loadChat()
        case let .addChat(message):
            addChatToRepository(message: message, direction: .right)
            getGPTAnswer(message: message)
        }
    }
    
    private func loadChat() {
        repository.observeChat()
            .sink { [weak self] chatObjects in
                guard let self else { return }

                let chats = chatObjects.map { chatObject in
                    Chat(
                        message: chatObject.message,
                        date: chatObject.date,
                        direction: chatObject.direction ? .left : .right
                    )
                }

                let groupedChats = Dictionary(grouping: chats) { self.formatDate($0.date) }

                let chatDataList = groupedChats.map { dateStr, chats in
                    ChatData(dateStr: dateStr, chats: chats)
                }

                self.makeDigginBotAnswer(chatDataList)
                self.chatDataList = chatDataList
            }
            .store(in: &subscription)
    }
    
    private func makeDigginBotAnswer(_ chatDataList: [ChatData]) {
        guard chatDataList.isEmpty else { return }

        let chatObjects = ChatObject(
            message: "Diggin에 방문해주셔서 감사해요. \n오늘의 음악을 추천드릴게요. \n저에게 오늘의 기분과 어떤 장르의 음악을 듣고 싶은지 말씀해주세요",
            date: Date(),
            direction: true
        )

        repository.addChat(chatObjects)
            .sink { _ in } receiveValue: { [weak self] _ in
                self?.message = ""
            }
            .store(in: &subscription)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: date)
    }
    
    private func addChatToRepository(message: String, direction: ChatItemDirection) {
        let chat: Chat = .init(message: message,
                               date: Date(),
                               direction: direction)
        let chatObject = ChatObject(message: chat.message!,
                                    date: chat.date,
                                    direction: direction == .right ? false : true)
        
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
