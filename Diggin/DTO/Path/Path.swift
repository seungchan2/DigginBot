//
//  Path.swift
//  Diggin
//
//  Created by 김승찬 on 2023/11/30.
//

import Foundation

class PathModel: ObservableObject {
    @Published var paths: [PathType]
    
    init(paths: [PathType] = []) {
        self.paths = paths
    }
}
