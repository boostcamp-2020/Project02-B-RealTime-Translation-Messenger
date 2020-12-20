//
//  ChatRoomInfo.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/02.
//

import Foundation

struct ChatRoomInfo: Equatable {
    var userID: Int
    var roomID: Int
    var code: String
    var token: String
    
    init(userID: Int, roomID: Int, code: String, token: String) {
        self.userID = userID
        self.roomID = roomID
        self.code = code
        self.token = token
    }
    
    init(response: JoinChatResponse, code: String) {
        self.userID = response.userId
        self.roomID = response.roomId
        self.code = code
        self.token = response.token
    }
}
