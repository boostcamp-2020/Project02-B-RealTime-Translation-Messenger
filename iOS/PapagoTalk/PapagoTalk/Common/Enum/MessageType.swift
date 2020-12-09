//
//  MessageType.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/30.
//

import Foundation

enum MessageType: String, Codable {
    case sent
    case received
    case translated
    case system
    
    var identifier: String {
        switch self {
        case .sent:
            return SentMessageCell.identifier
        case .received:
            return ReceivedMessageCell.identifier
        case .translated:
            return TranslatedMessageCell.identifier
        case .system:
            return SystemMessageCell.identifier
        }
    }
}
