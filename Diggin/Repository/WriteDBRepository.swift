//
//  WriteDBRepository.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/06.
//

import Combine
import Foundation

import RealmSwift

protocol WriteDBRepositoryType {
    func addMusicList(_ object: WriteObject) -> AnyPublisher<Void, DBError>
    func observeMusicList() -> AnyPublisher<[WriteObject], Never>
}

final class WriteDBRepository: WriteDBRepositoryType {
    private var subscription = Set<AnyCancellable>()
    
    let localRealm = try! Realm()
    var task: Results<WriteObject>!
    
    func addMusicList(_ object: WriteObject) -> AnyPublisher<Void, DBError> {
        Future<Void, DBError> { promise in
            do {
                try self.localRealm.write {
                    self.localRealm.add(object)
                }
                promise(.success(()))
                print("add")

                print(Realm.Configuration.defaultConfiguration.fileURL!)
            } catch {
                print("err''")
                promise(.failure(DBError.dbError))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func observeMusicList() -> AnyPublisher<[WriteObject], Never> {
        let subject = PassthroughSubject<[WriteObject], Never>()
        
        let token = localRealm.objects(WriteObject.self)
            .collectionPublisher
            .sink { completion in
                if case let .failure(error) = completion {
                    subject.send(completion: .finished)
                }
            } receiveValue: { results in
                subject.send(Array(results))
                print("observe")
                print(Realm.Configuration.defaultConfiguration.fileURL!)
            }
        
        subscription.insert(AnyCancellable {
            token.cancel()
        })
        
        return subject.eraseToAnyPublisher()
    }
}
