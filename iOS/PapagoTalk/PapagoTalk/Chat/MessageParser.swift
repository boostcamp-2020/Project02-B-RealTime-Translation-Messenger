//
//  MessageParser.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/06.
//

import Foundation

struct MessageParser: MessageParseProviding {
    
    var userData: UserDataProviding
    
    func parse(newMessage: GetMessageSubscription.Data.NewMessage) -> [Message] {
        guard let timeStamp = newMessage.createdAt,
              let json = newMessage.text.data(using: .utf8),
              let translateResult: TranslatedResult = try? json.decoded() else {
            return []
        }
        var messages = [Message]()
        let time = String(timeStamp.prefix(10))
        let sender = User(id: newMessage.user.id,
                          nickName: newMessage.user.nickname,
                          image: newMessage.user.avatar,
                          language: Language.codeToLanguage(of: newMessage.user.lang))
        let originMessage = Message(id: newMessage.id,
                                    of: translateResult.originText,
                                    by: sender,
                                    language: newMessage.source,
                                    timeStamp: time)
        messages.append(originMessage)
        
        if newMessage.user.id != userData.id &&
            Language.codeToLanguage(of: newMessage.user.lang) != userData.language {
            let translatedMessage = Message(id: newMessage.id,
                                            of: translateResult.translatedText,
                                            by: sender,
                                            language: userData.language.code,
                                            timeStamp: time,
                                            isTranslated: true)
            messages.append(translatedMessage)
        }
        return messages
    }
}
