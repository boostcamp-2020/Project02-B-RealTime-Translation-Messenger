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
              let data = newMessage.text.data(using: .utf8),
              let translatedResult: TranslatedResult = try? data.decoded()
        else {
            return []
        }
        
        var messages = [Message]()
        let sender = User(id: newMessage.user.id,
                          nickName: newMessage.user.nickname,
                          image: newMessage.user.avatar,
                          language: Language.codeToLanguage(of: newMessage.user.lang))
        let originMessage = Message(data: newMessage, with: translatedResult, timeStamp: timeStamp)
        messages.append(originMessage)
        
        let messageLanguage = Language.codeToLanguage(of: newMessage.source)
        let setting = false
        
        guard messageLanguage != userData.language || messageLanguage != sender.language || setting else {
            return messages
        }
        
        let translatedMessage = Message(data: newMessage, with: translatedResult, timeStamp: timeStamp, isTranslated: true)
        messages.append(translatedMessage)
        
        return messages
    }
}
