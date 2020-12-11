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
        
        guard newMessage.source != "in",
              newMessage.source != "out" else {
            let systemMessageText = newMessage.source == "in" ?
                Strings.Chat.userJoinMessage : Strings.Chat.userLeaveMessage

            return [Message(systemText: newMessage.user.nickname + systemMessageText,
                            timeStamp: newMessage.createdAt ?? "")]
        }

        guard let timeStamp = newMessage.createdAt,
              let data = newMessage.text.data(using: .utf8),
              let translatedResult: TranslatedResult = try? data.decoded()
        else {
            return []
        }
        
        var messages = [Message]()
      
        let sender = User(data: newMessage.user)
        let originMessage = Message(data: newMessage, with: translatedResult, timeStamp: timeStamp)
        messages.append(originMessage)
        
        let messageLanguage = Language.codeToLanguage(of: newMessage.source)
        let setting = false
        
        //        guard messageLanguage != userData.language || messageLanguage != sender.language || setting else {
        //            return messages
        //        }
        
        let translatedMessage = Message(data: newMessage, with: translatedResult, timeStamp: timeStamp, isTranslated: true)
        messages.append(translatedMessage)
        
        return messages
    }
    
    func parse(missingMessages: [GetMessageByTimeQuery.Data.AllMessagesByTime?]?) -> [Message] {
        guard let messages = missingMessages, !messages.isEmpty else {
            return []
        }
        var parsedMessages = [Message]()
        
        for message in messages {
            guard let message = message else { return parsedMessages }
            
            if message.source == "in" || message.source == "out" {
                let systemMessageText = message.source == "in" ?
                   Strings.Chat.userJoinMessage : Strings.Chat.userLeaveMessage
                parsedMessages.append(Message(systemText: message.user.nickname + systemMessageText,
                                       timeStamp: message.createdAt ?? ""))
                break
            }
            
            if let timeStamp = message.createdAt,
               let data = message.text.data(using: .utf8),
               let translatedResult: TranslatedResult = try? data.decoded() {
                
                let originMessage = Message(data: message, with: translatedResult, timeStamp: timeStamp)
                parsedMessages.append(originMessage)
                
                let translatedMessage = Message(data: message, with: translatedResult, timeStamp: timeStamp, isTranslated: true)
                parsedMessages.append(translatedMessage)
            }
        }
        return parsedMessages
    }
}
