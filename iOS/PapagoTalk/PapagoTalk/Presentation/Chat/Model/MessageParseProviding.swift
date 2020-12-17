//
//  MessageParseProviding.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/08.
//

import Foundation

protocol MessageParseProviding {
    func parse(newMessage: MessageData) -> [Message]
    func parse(missingMessages: [MessageData?]?) -> [Message]
}
