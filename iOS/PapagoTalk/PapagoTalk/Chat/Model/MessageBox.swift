//
//  MessageBox.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/26.
//

import Foundation

final class MessageBox {
    
    var messages = [Message]()
    
    func append(_ messages: [Message]) {
        messages.forEach { append($0) }
    }
    
    func append(_ message: Message) {
        var message = message
        
        guard let lastMessage = messages.last else {
            messages.append(message)
            return
        }
        
        guard isAppropriateMessage(of: message, comparedBy: lastMessage) else {
            return
        }
        
        message = setMessageIsFirst(of: message, comparedBy: lastMessage)
        message = setShouldImageShow(of: message, comparedBy: lastMessage)
        setShouldTimeShow(of: message, comparedBy: lastMessage)
        messages.append(message)
    }
    
    func lastMessageTimeStamp() -> String {
        guard let lastMessage = messages.last else {
            return Date.presentTimeStamp()
        }
        return lastMessage.timeStamp
    }
    
    private func isAppropriateMessage(of newMessage: Message, comparedBy lastMessage: Message) -> Bool {
        lastMessage.time <= newMessage.time
    }
    
    private func setMessageIsFirst(of newMessage: Message, comparedBy lastMessage: Message) -> Message {
        let isNotFirstOfDay = Calendar.isSameDate(of: newMessage.time, with: lastMessage.time)
        var message = newMessage
        message.setIsFirst(with: !isNotFirstOfDay)
        return message
    }
    
    private func setShouldImageShow(of newMessage: Message, comparedBy lastMessage: Message) -> Message {
        guard isSuccessiveReceive(of: newMessage, comparedBy: lastMessage),
              isSameTime(of: newMessage, comparedBy: lastMessage)
        else {
            return newMessage
        }
        var message = newMessage
        message.shouldImageShow = false
        return message
    }
    
    private func setShouldTimeShow(of newMessage: Message, comparedBy lastMessage: Message) {
        guard newMessage.sender.id == lastMessage.sender.id,
              DateFormatter.chatTimeFormat(of: newMessage.time) == DateFormatter.chatTimeFormat(of: lastMessage.time) else {
            messages.append(newMessage)
            return
        }
        var lastMessage = lastMessage
        lastMessage.shouldTimeShow = false
        messages.removeLast()
        messages.append(contentsOf: [lastMessage, newMessage])
    }
}
