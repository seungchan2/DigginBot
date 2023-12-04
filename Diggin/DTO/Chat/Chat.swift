//
//  Chat.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/05.
//

import Foundation

struct Chat: Hashable, Identifiable {
    var message: String?
    var date: Date
    var direction: ChatItemDirection
    var id: String { message! }
}
