//
//  MockMessageFactory.swift
//  MessageModelTests
//
//  Created by Byoung-Hwi Yoon on 2020/12/16.
//

import Foundation

struct MockMessageFactory {
    
    func message(messageID: Int, senderID: Int, source: String) -> MockMessage {
        MockMessage(id: messageID,
                    text: "{\"originText\":\"OriginText\",\"translatedText\":\"TranslatedText\"}",
                    userData: MockUserData(id: senderID,
                                           nickname: "nickname",
                                           avatar: "avatar",
                                           lang: "lang"),
                    source: source,
                    createdAt: "")
    }
}
