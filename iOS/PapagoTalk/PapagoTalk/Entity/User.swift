//
//  User.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/26.
//

import Foundation
import Apollo

struct User: Codable {
    var id: Int
    var nickName: String
    var image: String
    var language: Language
    var isMe: Bool
    
    init(id: Int, nickName: String, image: String, language: Language) {
        self.id = id
        self.nickName = nickName
        self.image = image
        self.language = language
        self.isMe = false
    }
    
    init(id: Int, nickName: String, image: String, language: Language, userID: Int) {
        self.id = id
        self.nickName = nickName
        self.image = image
        self.language = language
        self.isMe = (id == userID) ? true : false
    }
    
    typealias GetMessageUserData = GetMessageSubscription.Data.NewMessage.User
    
    init(data: GetMessageUserData) {
        self.id = data.id
        self.nickName = data.nickname
        self.image = data.avatar
        self.language = .codeToLanguage(of: data.lang)
        self.isMe = false
    }
    
    typealias GetUserListUserData = FindRoomByIdQuery.Data.RoomById.User
    
    init(data: GetUserListUserData, userID: Int) {
        self.id = data.id
        self.nickName = data.nickname
        self.image = data.avatar
        self.language = .codeToLanguage(of: data.lang)
        self.isMe = (id == userID) ? true : false
    }
    
    init(_ imageFactory: ImageFactoryProviding = ImageFactory()) {
        self.id = 0
        self.nickName = ""
        self.image = imageFactory.randomImageURL()
        self.language = Locale.currentLanguage
        self.isMe = true
    }
}
