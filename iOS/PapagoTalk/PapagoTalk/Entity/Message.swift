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
    var isTranslated: Bool
    var shouldTimeShow: Bool = true
    var shouldImageShow: Bool = true
    
    init(of text: String, by sender: User) {
        self.id = nil
        self.text = text
        self.sender = sender
        self.language = sender.language.code
        self.timeStamp = Date()
        self.isFirstOfDay = true
        self.type = .sent
        isTranslated = false
    }
    
    init(id: Int, of text: String, by sender: User, language: String, timeStamp: String, isTranslated: Bool = false) {
        self.id = id
        self.text = text
        self.sender = sender
        self.language = language
        self.timeStamp = timeStamp.toDate()
        self.isFirstOfDay = true
        self.type = .received
        self.isTranslated = isTranslated
    }
    
    mutating func setIsFirst(with isFirst: Bool) {
        isFirstOfDay = isFirst
    }
    
    mutating func setType(by userID: Int) {
        if isTranslated {
            type = .translated
            return
        }
        type = (sender.id == userID) ? .sent : .received
    }
}
