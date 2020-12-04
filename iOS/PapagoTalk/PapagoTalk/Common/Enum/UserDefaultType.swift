//
//  UserDefaultType.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/29.
//

import Foundation

enum UserDefaultType {
    case userInfo
    
    var key: String {
        switch self {
        case .userInfo:
            return "userInfo"
        }
    }
}
