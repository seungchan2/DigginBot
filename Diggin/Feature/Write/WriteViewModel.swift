//
//  WriteViewModel.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/06.
//

import Combine
import Foundation

import RealmSwift

final class WriteViewModel: ObservableObject {
    
    @Published var titleText: String = ""
    @Published var artistText: String = ""
    @Published var contentText: String = ""
    @Published var diaryImage: Data?
    private var subscription = Set<AnyCancellable>()

    enum Action {
        case addMusicList(title: String,
                          artist: String,
                          content: String)
    }
    
    private var repository: WriteDBRepositoryType
    
    init(repository: WriteDBRepositoryType) {
        self.repository = repository
    }
    
    private func bind() {
       
    }
    
    func send(action: Action) {
        switch action {
        case let .addMusicList(titleText, artistText, contentText):
         
            self.addMusicList(title: titleText,
                              artist: artistText,
                              content: contentText)
        }
    }
    
    private func addMusicList(title:
                              String,
                              artist:
                              String, content: String
    ) {
        let musicObject = WriteObject(title: title,
                                      artist: artist,
                                      content: content,
                                      writeDate: Date())
        
        repository.addMusicList(musicObject)
            .sink { completion in
            } receiveValue: { [weak self] _ in
                self?.titleText = ""
            }
            .store(in: &subscription)
    }
}
