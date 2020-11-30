//
//  Strings.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/29.
//

import Foundation

struct Strings {
    
    // MARK: - Common
    static let english = "English".localized
    static let korean = "Korean".localized
    static let ok = "OK".localized
    
    // MARK: - Network
    struct Network {
        static let connectionAlertMessage = "Please Check your Network Connection".localized
    }
    
    // MARK: - Home
    struct Home {
        static let invalidNickNameAlertMessage = "Please Enter 2-12 Characters for NickName".localized
    }
    
    // MARK: - JoinChat
    struct JoinChat {
        static let noSuchRoomAlertMessage = "Chat Room is Doesn't Exist \n Or already Deleted".localized
    }
}
