//
//  HomeError.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/30.
//

import Foundation

enum HomeError: Error {
    case invalidNickName
    case networkError
    
    var message: String {
        switch self {
        case .invalidNickName:
            return Strings.Home.invalidNickNameAlertMessage
        case .networkError:
            return Strings.Network.connectionAlertMessage
        }
    }
}
