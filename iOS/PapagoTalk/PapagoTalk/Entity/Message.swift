//
//  Message.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/26.
//

import Foundation

struct Message {
    let id: Int?
    let text: String
    let language: String?
    let sender: User?
    let timeStamp: String?
}
