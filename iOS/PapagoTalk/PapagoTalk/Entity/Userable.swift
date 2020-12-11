//
//  Userable.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/11.
//

import Foundation

protocol Userable {
    var id: Int { get set }
    var nickname: String { get set }
    var avatar: String { get set }
    var lang: String { get set }
}

typealias GetMessageUserData = GetMessageSubscription.Data.NewMessage.User
typealias GetMissingMessageUserData = GetMessageByTimeQuery.Data.AllMessagesByTime.User
typealias GetUserListData = FindRoomByIdQuery.Data.RoomById.User

extension GetMessageUserData: Userable {
}

extension GetMissingMessageUserData: Userable {
}

extension GetUserListData: Userable {
}
