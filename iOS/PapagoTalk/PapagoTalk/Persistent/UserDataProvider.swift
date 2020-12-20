//
//  UserDataProvider.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/01.
//

import Foundation

struct UserDataProvider: UserDataProviding {
    
    @UserDefault(type: .userInfo, default: User()) var user: User
    @UserDefault(type: .micButtonSize, default: .small) var micButtonSize: MicButtonSize
    @UserDefault(type: .sameLanguageTranslation, default: true) var sameLanguageTranslation: Bool
    
    @Keychain(key: "jwt", defaultValue: "") var token: String
    
    func removeToken() {
        try? KeychainAccess.shared.removeAll()
    }
}
