//
//  GetMissingMessageData.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/17.
//

import Foundation

typealias GetMissingMessageData = GetMessageByTimeQuery.Data.AllMessagesByTime

extension GetMissingMessageData: MessageData {
    var userData: UserData {
        return self.user
    }
}
