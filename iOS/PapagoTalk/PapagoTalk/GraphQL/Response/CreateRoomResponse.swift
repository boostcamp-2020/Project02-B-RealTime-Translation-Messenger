//
//  CreateRoomResponse.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/30.
//

import Foundation

typealias CreateRoomResponse = CreateRoomMutation.Data.CreateRoom

extension CreateRoomResponse: Equatable {
    public static func == (lhs: CreateRoomMutation.Data.CreateRoom, rhs: CreateRoomMutation.Data.CreateRoom) -> Bool {
        lhs.userId == rhs.userId && lhs.roomId == rhs.roomId
    }
}
