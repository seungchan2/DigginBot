//
//  WriteObject.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/06.
//

import Foundation

import RealmSwift

final class WriteObject: Object {
    @Persisted var title: String
    @Persisted var artist: String
    @Persisted var content: String
    @Persisted var writeDate: Date
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(title: String,
                     artist: String,
                     content: String,
                     writeDate: Date) {
        self.init()
        self.title = title
        self.artist = artist
        self.content = content
        self.writeDate = writeDate
    }
}
