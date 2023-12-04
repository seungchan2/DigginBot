//
//  MusicList.swift
//  Diggin
//
//  Created by 김승찬 on 2023/11/30.
//

import Foundation

struct MusicList: Hashable {
    var title: String
    var artist: String
    var day: Date
    var selected: Bool
    
    var convertedDayAndTime: String {
        String("\(day.formattedDay)")
    }
}
