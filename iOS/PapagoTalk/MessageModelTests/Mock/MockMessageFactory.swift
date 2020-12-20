//
//  MockMessageFactory.swift
//  MessageModelTests
//
//  Created by Byoung-Hwi Yoon on 2020/12/16.
//

import Foundation

struct MockMessageFactory {
    
    func message(messageID: Int, senderID: Int, source: String) -> MockMessageData {
        let mockUserData = MockUserData(id: senderID, nickname: "nickname", avatar: "avatar", lang: "lang")
        
        return MockMessageData(id: messageID,
                               text: "{\"originText\":\"OriginText\",\"translatedText\":\"TranslatedText\"}",
                               userData: mockUserData,
                               source: source,
                               createdAt: "")
    }
    
    func translationFailedMessage(messageID: Int, senderID: Int, source: String) -> MockMessageData {
        let mockUserData = MockUserData(id: senderID, nickname: "nickname", avatar: "avatar", lang: "lang")
        
        return MockMessageData(id: messageID,
                               text: "{\"originText\":\"OriginText\",\"translatedText\":\"\"}",
                               userData: mockUserData,
                               source: source,
                               createdAt: "")
    }
}
