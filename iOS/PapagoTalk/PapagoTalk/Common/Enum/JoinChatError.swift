//
//  JoinChatError.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/29.
//

import Foundation

enum JoinChatError: Error {
    case cannotFindRoom
    case networkError
    
    var message: String {
        switch self {
        case .cannotFindRoom:
            return Strings.JoinChat.noSuchRoomAlertMessage
        case .networkError:
            return Strings.Network.connectionAlertMessage
        }
    }
}
