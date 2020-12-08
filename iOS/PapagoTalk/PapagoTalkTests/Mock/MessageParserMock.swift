//
//  MessageParserMock.swift
//  PapagoTalkTests
//
//  Created by 송민관 on 2020/12/08.
//

import Foundation

struct MessageParserMock: MessageParseProviding {
    func parse(newMessage: GetMessageSubscription.Data.NewMessage) -> [Message] {
        var messages = [Message]()
        let time = String((newMessage.createdAt ?? "").prefix(10))
        let sender = User(id: newMessage.user.id,
                          nickName: newMessage.user.nickname,
                          image: newMessage.user.avatar,
                          language: Language.codeToLanguage(of: newMessage.user.lang))
        let originMessage = Message(id: newMessage.id,
                                    of: newMessage.text,
                                    by: sender,
                                    language: newMessage.source,
                                    timeStamp: time)
        messages.append(originMessage)
        return messages
    }
}
