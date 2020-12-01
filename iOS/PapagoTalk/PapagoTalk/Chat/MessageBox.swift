//
//  MessageBox.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/26.
//

import Foundation

final class MessageBox {
    var messages = [Message]()
    
    func append(_ message: Message) {
        guard let lastMessage = messages.last else {
            messages.append(message)
            return
        }
        var message = setMessageIsFirst(of: message, comparedBy: lastMessage)
        message = setType(of: message)
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
        message.setType(by: newMessage.sender)
        return message
    }
}
