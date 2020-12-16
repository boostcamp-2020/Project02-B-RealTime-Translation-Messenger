//
//  MessageType.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/30.
//

import Foundation

enum MessageType: String, Codable {
    case sent
    case sentTranslated
    case received
    case translated
    case system
    
    var identifier: String {
        switch self {
        case .sent:
            return "SentMessageCell"
        case .sentTranslated:
            return "UserTranslatedMessageCell"
        case .received:
            return "ReceivedMessageCell"
        case .translated:
            return "TranslatedMessageCell"
        case .system:
            return "SystemMessageCell"
        }
    }
}
