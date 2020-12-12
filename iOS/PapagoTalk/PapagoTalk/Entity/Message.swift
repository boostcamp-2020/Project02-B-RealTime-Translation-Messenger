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
    var isFirstOfDay: Bool
    var type: MessageType
    var isTranslated: Bool
    var shouldTimeShow: Bool = true
    var shouldImageShow: Bool = true
    
    var time: Date {
        return timeStamp.toDate()
    }
    
    init(of text: String, by sender: User) {
        self.id = nil
        self.text = text
        self.sender = sender
        self.language = sender.language.code
        self.timeStamp = ""
        self.isFirstOfDay = true
        self.type = .sent
        isTranslated = false
    }
    
    init(data: Messageable, with text: TranslatedResult, timeStamp: String, isTranslated: Bool = false) {
        self.id = data.id
        self.text = isTranslated ? text.translatedText : text.originText
        self.sender = User(data: data.userData)
        self.language = data.source
        self.timeStamp = timeStamp
        self.isFirstOfDay = true
        self.type = .received
        self.isTranslated = isTranslated
    }
    
    init(systemText: String, timeStamp: String) {
        self.id = 0
        self.text = systemText
        self.sender = User()
        self.language = ""
        self.timeStamp = timeStamp
        self.isFirstOfDay = true
        self.type = .system
        self.isTranslated = false
    }
    
    mutating func setIsFirst(with isFirst: Bool) {
        isFirstOfDay = isFirst
    }
    
    mutating func setType(by userID: Int) {
        guard sender.id != userID else {
            type = isTranslated ? .sentTranslated : .sent
            return
        }
        type = isTranslated ? .translated : .received
    }
}
