//
//  User.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/26.
//

import Foundation

struct User: Codable {
    let id: Int?
    let nickName: String
    let image: String
    let language: Language
    
    init(id: Int?, nickName: String, image: String, language: Language) {
        self.id = id
        self.nickName = nickName
        self.image = image
        self.language = language
    }
    
    init() {
        id = 1
        nickName = ""
        image = ""
        language = .korean
    }
}
