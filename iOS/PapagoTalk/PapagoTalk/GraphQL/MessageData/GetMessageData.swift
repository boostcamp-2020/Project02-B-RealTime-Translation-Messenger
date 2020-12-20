//
//  GetMessageData.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/17.
//

import Foundation

typealias GetMessageData = GetMessageSubscription.Data.NewMessage

extension GetMessageData: MessageData {
    var userData: UserData {
        return self.user
    }
}
