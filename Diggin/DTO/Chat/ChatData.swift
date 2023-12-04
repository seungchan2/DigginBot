//
//  ChatData.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/05.
//

import Foundation

struct ChatData: Hashable, Identifiable {
    var dateStr: String
    var chats: [Chat]
    var id: String { dateStr }
}
