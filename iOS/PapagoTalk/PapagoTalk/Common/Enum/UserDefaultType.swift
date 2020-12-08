//
//  UserDefaultType.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/29.
//

import Foundation

enum UserDefaultType {
    case userInfo
    case micButtonSize
    
    var key: String {
        switch self {
        case .userInfo:
            return "userInfo"
        case .micButtonSize:
            return "micButtonSize"
        }
    }
}
