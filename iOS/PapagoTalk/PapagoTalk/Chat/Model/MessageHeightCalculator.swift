//
//  MessageHeightCalculator.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/12.
//

import UIKit

struct MessageHeightCalculator {
    func height(of message: Message) -> CGFloat {
        switch message.type {
        case .received:
            return receivedMessageHeight(of: message)
        case .sent:
            return sentMessageHeight(of: message)
        case .sentTranslated:
            return translatedMessageHeight(of: message)
        case .system:
            return systemMessageHeight(of: message)
        case .translated:
            return translatedMessageHeight(of: message)
            
        }
    }
    
    private func sentMessageHeight(of message: Message) -> CGFloat {
        let dateBadgeHeight = message.isFirstOfDay ? Constant.dateBadgeHeight : 0
        let inset = (Constant.dateBadgeInset + Constant.messageInset) * 2
        return messageTextHeight(of: message.text) + dateBadgeHeight + inset
    }
    
    private func receivedMessageHeight(of message: Message) -> CGFloat {
        let dateBadgeHeight = message.isFirstOfDay ? Constant.dateBadgeHeight : 0
        let inset = message.shouldImageShow ? (Constant.dateBadgeInset + Constant.messageInset) * 2 :
            (Constant.dateBadgeInset + Constant.messageInset)
        let nicknameHeight = message.shouldImageShow ? (Constant.nicknameTextHeight + Constant.nicknameTextInset) : 0
        
        return messageTextHeight(of: message.text) + dateBadgeHeight + nicknameHeight + inset
    }
    
    private func systemMessageHeight(of message: Message) -> CGFloat {
        Constant.systemMessageCellHeight
    }
    
    private func translatedMessageHeight(of message: Message) -> CGFloat {
        let inset = Constant.translatedMessageBottomInset
        return messageTextHeight(of: message.text) + inset
    }
    
    private func messageTextHeight(of text: String) -> CGFloat {
        let maxSize = CGSize(width: 240, height: CGFloat.greatestFiniteMagnitude)
        let font = UIFont.init(name: "Helvetica", size: 14) ?? UIFont.systemFont(ofSize: 14)
        let textHeight = text.boundingRect(with: maxSize,
                                 options: [.usesLineFragmentOrigin],
                                 attributes: [.font: font],
                                 context: nil).height
        return textHeight + Constant.messageInset * 2 + 1
    }
}
