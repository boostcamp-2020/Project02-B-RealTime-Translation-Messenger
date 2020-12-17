//
//  MockUserDataProvider.swift
//  PapagoTalkTests
//
//  Created by 송민관 on 2020/12/08.
//

import Foundation

struct MockUserDataProvider: UserDataProviding {
    var user: User
    var micButtonSize = MicButtonSize.medium
    var token = "testToken"
    var sameLanguageTranslation: Bool = true
    
    init() {
        user = User(id: 1, nickName: "test", image: "", language: .english)
    }
    
    init(id: Int, nickName: String, image: String, language: Language) {
        user = User(id: id, nickName: nickName, image: image, language: language)
    }
    
    init(nickName: String) {
        user = User(id: 1, nickName: nickName, image: "", language: .english)
    }
    
    init(language: Language) {
        user = User(id: 1, nickName: "test", image: "", language: language)
    }
    
    func removeToken() {
    }
}
