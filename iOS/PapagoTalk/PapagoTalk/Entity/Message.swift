//
//  Message.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/26.
//

import Foundation

struct Message: Codable {
    let id: Int?
    let text: String
    let sender: User
    let language: String
    let timeStamp: String
    
    init(of body: String) {
        let user = ChatViewController.user
        id = nil
        text = body
        sender = user
        language = user.language.code
        timeStamp = DateFormatter.format(of: Date())
    }
    
    init(id: Int, text: String, sender: User, language: String, timeStamp: String) {
        self.id = id
        self.text = text
        self.sender = sender
        self.language = language
        self.timeStamp = timeStamp
    }
    
    init(userId: Int, text: String) {
        self.id = nil
        self.text = text
        self.sender = User(id: userId, nickName: "", image: "", language: .english)
        self.language = "ko"
        self.timeStamp = "2020"
    }
}
