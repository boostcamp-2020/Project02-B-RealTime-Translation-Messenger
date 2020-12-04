//
//  MessageBox.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/26.
//

import Foundation

final class MessageBox {
    
    var currentUserID: Int
    var messages = [Message]()
    
    init(userID: Int) {
        currentUserID = userID
    }
    
    func append(_ messages: [Message]) {
        messages.forEach { append($0) }
    }
    
    func append(_ message: Message) {
        var message = message
        message = setType(of: message)
        
        guard let lastMessage = messages.last else {
            messages.append(message)
            return
        }
        message = setMessageIsFirst(of: message, comparedBy: lastMessage)
        messages.append(message)
    }
    
    func setMessageIsFirst(of newMessage: Message, comparedBy lastMessage: Message) -> Message {
        let isNotFirstOfDay = Calendar.isSameDate(of: newMessage.timeStamp, with: lastMessage.timeStamp)
        var message = newMessage
        message.setIsFirst(with: !isNotFirstOfDay)
        return message
    }
    
    func setType(of newMessage: Message) -> Message {
        var message = newMessage
        message.setType(by: currentUserID)
        return message
    }
}
