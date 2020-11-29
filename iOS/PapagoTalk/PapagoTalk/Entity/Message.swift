//
//  Message.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/26.
//

import Foundation

struct Message: Codable {
    let id: Int
    let text: String
    let language: Language
    let sender: User
    let timeStamp: String
    
    init(userId: Int, text: String) {
        id = 1
        self.text = text
        language = .korean
        timeStamp = "2020"
        sender = User(id: userId, nickName: "HAHA", image: "", language: .korean)
    }
}
