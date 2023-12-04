//
//  Config.swift
//  Diggin
//
//  Created by 김승찬 on 2023/12/05.
//

import Foundation

enum Config {
    
    enum Keys {
        enum Plist {
            static let apiKey = "APIKEY"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist cannot found.")
        }
        return dict
    }()
}

extension Config {
    static let apiKey: String = {
        guard let key = Config.infoDictionary[Keys.Plist.apiKey] as? String else {
            fatalError("APIKEY is not set in plist for this configuration.")
        }
        return key
    }()
}
