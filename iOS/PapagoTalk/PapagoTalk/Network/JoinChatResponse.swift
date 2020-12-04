//
//  JoinChatResponse.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/29.
//

import Foundation

typealias JoinChatResponse = EnterRoomMutation.Data.EnterRoom

extension JoinChatResponse: Equatable {
    public static func == (lhs: EnterRoomMutation.Data.EnterRoom, rhs: EnterRoomMutation.Data.EnterRoom) -> Bool {
        lhs.userId == rhs.userId && lhs.roomId == rhs.roomId
    }
}
