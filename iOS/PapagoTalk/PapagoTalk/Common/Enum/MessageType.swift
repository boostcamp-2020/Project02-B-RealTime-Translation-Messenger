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
            return "SentOriginMessageCell"
        case .sentTranslated:
            return "SentTranslatedMessageCell"
        case .receivedOrigin:
            return "ReceivedOriginMessageCell"
        case .receivedTranslated:
            return "ReceivedTranslatedMessageCell"
        case .system:
            return "SystemMessageCell"
        }
    }
}
