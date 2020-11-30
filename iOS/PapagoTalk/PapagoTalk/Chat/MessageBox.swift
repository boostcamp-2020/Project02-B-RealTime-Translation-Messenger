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
        messages.append(setMessageIsFirst(of: message, comparedBy: lastMessage))
    }
    
    func setMessageIsFirst(of newMessage: Message, comparedBy lastMessage: Message) -> Message {
        let isSameDate = Calendar.isSameDate(of: newMessage.timeStamp, with: lastMessage.timeStamp)
        var message = newMessage
        message.setIsFirst(with: isSameDate)
        return message
    }
}
