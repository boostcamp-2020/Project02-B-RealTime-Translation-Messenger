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
    let timeStamp: Date
    var isFirstOfDay: Bool
    var type: MessageType
    
    // App -> API
    init(of text: String, by user: User) {
        self.id = nil
        self.text = text
        self.sender = user
        self.language = user.language.code
        self.timeStamp = Date()
        self.isFirstOfDay = true
        self.type = .sent
    }
    
    init(id: Int, of text: String, by user: User, language: String, timeStamp: String) {
        self.id = id
        self.text = text
        self.sender = user
        self.language = language
        self.timeStamp = timeStamp.toDate()
        self.isFirstOfDay = true
        self.type = .received
    }
    
    mutating func setIsFirst(with isFirst: Bool) {
        isFirstOfDay = isFirst
    }
    
    mutating func setType(by userID: Int) {
        type = (sender.id == userID) ? .sent : .received
    }
}
