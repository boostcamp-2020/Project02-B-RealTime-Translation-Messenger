//
//  MockUserData.swift
//  MessageModelTests
//
//  Created by Byoung-Hwi Yoon on 2020/12/16.
//

import Foundation

struct MockUserData: UserData {
    
    var id: Int 
    var nickname: String
    var avatar: String
    var lang: String
    
    init(id: Int, nickname: String, avatar: String, lang: String) {
        self.id = id
        self.nickname = nickname
        self.avatar = avatar
        self.lang = lang
    }
    
    init() {
        id = 0
        nickname = "nickName"
        avatar = "avatar"
        lang = "ko"
    }
}
