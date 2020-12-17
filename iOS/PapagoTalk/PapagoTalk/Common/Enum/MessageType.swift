//
//  MessageType.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/30.
//

import Foundation

enum MessageType: String, Codable {
    case sentOrigin
    case sentTranslated
    case receivedOrigin
    case receivedTranslated
    case system
    
    var identifier: String {
        switch self {
        case .sentOrigin:
            return "SentMessageCell"
        case .sentTranslated:
            return "UserTranslatedMessageCell"
        case .receivedOrigin:
            return "ReceivedMessageCell"
        case .receivedTranslated:
            return "TranslatedMessageCell"
        case .system:
            return "SystemMessageCell"
        }
    }
}
