//
//  WriteViewModel.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/06.
//

import Combine
import Foundation
import PhotosUI
import SwiftUI

import RealmSwift

final class WriteViewModel: ObservableObject {
    
    @Published var titleText: String = ""
    @Published var artistText: String = ""
    @Published var contentText: String = ""
    @Published var imageData: Data = Data()
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            Task {
                await updateImage(pickerItem: imageSelection)
            }
        }
    }
    
    var isButtonEnabledPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(
            $titleText,
            $artistText,
            $contentText
        )
        .map { title, artist, content in
            return !title.isEmpty && !artist.isEmpty && !content.isEmpty && !self.imageData.isEmpty
        }
        .eraseToAnyPublisher()
    }

    private var subscription = Set<AnyCancellable>()

    enum Action {
        case addMusicList(title: String,
                          artist: String,
                          content: String)
    }
    
    private var repository: WriteDBRepositoryType
    private var photoService: PhotoPickerServiceType
    
    init(repository: WriteDBRepositoryType,
         photoService: PhotoPickerServiceType) {
        self.repository = repository
        self.photoService = photoService
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
                                      writeDate: Date(),
                                      musicData: imageData)
        
        repository.addMusicList(musicObject)
            .sink { completion in
            } receiveValue: { [weak self] _ in
                self?.titleText = ""
            }
            .store(in: &subscription)
    }
    
    func updateImage(pickerItem: PhotosPickerItem?) async {
        guard let pickerItem else { return }
        
        do {
            let data = try await photoService.loadTransferable(from: pickerItem)
            DispatchQueue.main.async {
                self.imageData = data
            }
        } catch {
            print("error")
        }
    }
}
