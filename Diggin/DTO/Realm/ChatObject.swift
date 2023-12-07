//
//  ChatObject.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/04.
//

import Foundation

import RealmSwift

final class ChatObject: Object {
    @Persisted var message: String
    @Persisted var date: Date
    @Persisted var direction: Bool
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(message: String, date: Date, direction: Bool) {
        self.init()
        self.message = message
        self.date = date
        self.direction = direction
    }
}
