//
//  Messageable.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/11.
//

import Foundation

protocol Messageable {
    var id: Int { get set }
    var text: String { get set }
    var source: String { get set }
}

typealias GetMessageData = GetMessageSubscription.Data.NewMessage
typealias GetMissingMessageData = GetMessageByTimeQuery.Data.AllMessagesByTime

extension GetMessageData: Messageable {
}

extension GetMissingMessageData: Messageable {
}
