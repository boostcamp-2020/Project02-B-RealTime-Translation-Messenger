//
//  MockReceiver.swift
//  MessageModelTests
//
//  Created by Byoung-Hwi Yoon on 2020/12/16.
//

import Foundation

struct MockReceiver: UserDataProviding {
    var user: User
    var micButtonSize: MicButtonSize
    var sameLanguageTranslation: Bool
    var token: String
    
    init(userID: Int, language: Language, sameLanguageTranslation: Bool) {
        self.user = User(id: userID, nickName: "", image: "", language: language)
        self.micButtonSize = .none
        self.sameLanguageTranslation = sameLanguageTranslation
        self.token = ""
    }
    
    func removeToken() {
    }
}
