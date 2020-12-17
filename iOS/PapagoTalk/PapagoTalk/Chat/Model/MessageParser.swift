//
//  MessageParser.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/06.
//

import Foundation

struct MessageParser: MessageParseProviding {
    
    var userData: UserDataProviding
    
    func parse(newMessage: MessageData) -> [Message] {
        guard !isSystemMessage(newMessage) else {
            return [systemMessage(from: newMessage)]
        }

        guard let timeStamp = newMessage.createdAt,
              let data = newMessage.text.data(using: .utf8),
              let translatedResult: TranslatedResult = try? data.decoded()
        else {
            return []
        }
        
        var messages = [Message]()
      
        var originMessage = Message(data: newMessage, with: translatedResult, timeStamp: timeStamp)
        originMessage = setMessageType(of: originMessage)
        messages.append(originMessage)
        
        guard shouldTranslate(message: newMessage) else {
            return messages
        }
        
        var translatedMessage = Message(data: newMessage,
                                        with: translatedResult,
                                        timeStamp: timeStamp,
                                        isTranslated: true)
        translatedMessage = setMessageType(of: translatedMessage)
        
        guard !translatedMessage.text.isEmpty else {
            return messages
        }
        
        messages.append(translatedMessage)
        
        return messages
    }
    
    func parse(missingMessages: [MessageData?]?) -> [Message] {
        guard let messages = missingMessages, !messages.isEmpty else {
            return []
        }
        var parsedMessages = [Message]()
    
        messages.forEach {
            guard let message = $0 else { return }
            parsedMessages.append(contentsOf: parse(newMessage: message))
        }
        
        return parsedMessages
    }
    
    private func isSystemMessage(_ message: MessageData) -> Bool {
        message.source == "in" || message.source == "out"
    }
    
    private func shouldTranslate(message: MessageData) -> Bool {
        let messageLanguage = Language.codeToLanguage(of: message.source)
        return messageLanguage != userData.language || userData.sameLanguageTranslation
    }
    
    private func systemMessage(from message: MessageData) -> Message {
        switch message.source {
        case "in":
            return Message(systemText: message.userData.nickname + Strings.Chat.userJoinMessage,
                           timeStamp: message.createdAt ?? "")
        case "out":
            return Message(systemText: message.userData.nickname + Strings.Chat.userLeaveMessage,
                           timeStamp: message.createdAt ?? "")
        default:
            return Message(systemText: "", timeStamp: message.createdAt ?? "")
        }
    }
    
    private func setMessageType(of message: Message) -> Message {
        var message = message
        message.setType(by: userData.id)
        return message
    }
}
