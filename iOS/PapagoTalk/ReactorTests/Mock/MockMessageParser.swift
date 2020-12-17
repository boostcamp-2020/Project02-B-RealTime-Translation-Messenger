//
//  MockMessageParser.swift
//  PapagoTalkTests
//
//  Created by 송민관 on 2020/12/08.
//

import Foundation

struct MockMessageParser: MessageParseProviding {
    func parse(newMessage: MessageData) -> [Message] {
        var messages = [Message]()
        
        let translatedMock = TranslatedResult(originText: newMessage.text, translatedText: newMessage.text)
        let timeStamp = newMessage.createdAt ?? ""
        let messageMock = Message(data: newMessage, with: translatedMock, timeStamp: timeStamp)
        
        messages.append(messageMock)
        return messages
    }
    
    func parse(missingMessages: [MessageData?]?) -> [Message] {
        var messages = [Message]()
        
        guard let missingMessages = missingMessages else { return [] }
        
//        missingMessages.forEach({ message in
//            parse(newMessage: message )
//        })
        return messages
    }
}
