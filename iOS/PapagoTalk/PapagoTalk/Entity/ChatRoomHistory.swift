//
//  ChatRoomHistory.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/13.
//

import Foundation

struct ChatRoomHistory {
    var roomID: Int
    var code: String
    var title: String
    var usedNickname: String
    var usedLanguage: Language
    var usedImage: String
    var enterDate: Date
    
    init(roomID: Int,
         code: String,
         title: String,
         usedNickname: String,
         usedLanguage: Language,
         usedImage: String,
         enterDate: Date) {
        
        self.roomID = roomID
        self.code = code
        self.title = title
        self.usedNickname = usedNickname
        self.usedLanguage = usedLanguage
        self.usedImage = usedImage
        self.enterDate = enterDate
    }
    
    init(roomID: Int, code: String, title: String, userData: UserDataProviding) {
        self.roomID = roomID
        self.code = code
        self.title = title
        self.usedNickname = userData.nickName
        self.usedLanguage = userData.language
        self.usedImage = userData.image
        self.enterDate = Date()
    }
}
