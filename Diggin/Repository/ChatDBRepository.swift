//
//  ChatDBRepository.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/04.
//

import Foundation
import Combine

import RealmSwift

enum DBError: Error {
    case dbError
}

protocol ChatDBRepositoryType {
    func addChat(_ object: ChatObject) -> AnyPublisher<Void, DBError>
    func observeChat() -> AnyPublisher<[ChatObject], Never>
}

final class ChatDBRepository: ChatDBRepositoryType {
    private var subscription = Set<AnyCancellable>()
    
    let localRealm = try! Realm()
    var task: Results<ChatObject>!
    
    func addChat(_ object: ChatObject) -> AnyPublisher<Void, DBError> {
        Future<Void, DBError> { promise in
            do {
                try self.localRealm.write {
                    self.localRealm.add(object)
                }
                promise(.success(()))
            } catch {
                promise(.failure(DBError.dbError))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func observeChat() -> AnyPublisher<[ChatObject], Never> {
        let subject = PassthroughSubject<[ChatObject], Never>()
        
        let token = localRealm.objects(ChatObject.self)
            .collectionPublisher
            .sink { completion in
                if case let .failure(error) = completion {
                    subject.send(completion: .finished)
                }
            } receiveValue: { results in
                subject.send(Array(results))
            }
        
        subscription.insert(AnyCancellable {
            token.cancel()
        })
        
        return subject.eraseToAnyPublisher()
    }
}
