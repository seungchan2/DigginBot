//
//  PhotoPickerServiceType.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/07.
//

import Foundation
import SwiftUI
import PhotosUI

enum PhotoPickerError: Error {
    case importError
}

protocol PhotoPickerServiceType {
    func loadTransferable(from imageSelection: PhotosPickerItem) async throws -> Data
}

final class PhotoPickerService: PhotoPickerServiceType {
    func loadTransferable(from imageSelection: PhotosPickerItem) async throws -> Data {
        guard let image = try await imageSelection.loadTransferable(type: PhotoImage.self) else {
            throw PhotoPickerError.importError
        }
        
        return image.data
    }
}

struct PhotoImage: Transferable {
    
    let data: Data
    
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            guard let uiImage = UIImage(data: data) else {
                throw PhotoPickerError.importError
            }
            
            guard let data = uiImage.jpegData(compressionQuality: 0.3) else {
                throw PhotoPickerError.importError
            }
            
            return PhotoImage(data: data)
        }
    }
}
