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
            return "이미 삭제되었거나\n존재하지 않는 채팅방입니다."
        case .networkError:
            return "네트워크 연결을 확인해주세요"
        }
    }
}
