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
}
