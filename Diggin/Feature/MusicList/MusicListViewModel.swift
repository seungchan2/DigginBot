//
//  MusicListViewModel.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/06.
//

import Combine
import Foundation

import RealmSwift

struct MusicListData: Hashable, Identifiable {
    var title: String
    var artist: String
    var content: String
    var date: Date
    var musicImage: Data
    var id: String { title }
}

final class MusicListViewModel: ObservableObject {
    
    enum Action {
        case load
    }
    
    @Published var writeDataList: [MusicListData] = []
    private var subscription = Set<AnyCancellable>()
    private var repository: WriteDBRepositoryType
    
    init(repository: WriteDBRepositoryType) {
        self.repository = repository
        self.bind()
    }
    
    private func bind() {
        repository.observeMusicList()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] writeObjects in
                guard let self else { return }
                self.writeDataList = writeObjects.map { MusicListData(
                    title: $0.title,
                    artist: $0.artist,
                    content: $0.content,
                    date: $0.writeDate,
                    musicImage: $0.musicData ?? Data()
                )}
                
                print(self.writeDataList)
            }
            .store(in: &subscription)
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            self.bind()
        }
    }
}
