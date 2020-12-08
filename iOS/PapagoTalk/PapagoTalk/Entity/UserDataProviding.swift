//
//  UserDataProviding.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/01.
//

import Foundation

protocol UserDataProviding {
    var user: User { get set }
    var id: Int { get set }
    var nickName: String { get set }
    var image: String { get set }
    var language: Language { get set }
    
    var micButtonSize: MicButtonSize { get set }
}

extension UserDataProviding {
    var id: Int {
        get {
            user.id
        }
        set {
            user.id = newValue
        }
    }
    
    var nickName: String {
        get {
            user.nickName
        }
        set {
            user.nickName = newValue
        }
    }
    
    var image: String {
        get {
            user.image
        }
        set {
            user.image = newValue
        }
    }
    
    var language: Language {
        get {
            user.language
        }
        set {
            user.language = newValue
        }
    }
}
