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
        case .receivedOrigin:
            return receivedMessageHeight(of: message)
        case .sentOrigin:
            return sentMessageHeight(of: message)
        case .sentTranslated:
            return sentTranslatedMessageHeight(of: message)
        case .system:
            return systemMessageHeight(of: message)
        case .receivedTranslated:
            return translatedMessageHeight(of: message)
        }
    }
    
    private func sentMessageHeight(of message: Message) -> CGFloat {
        let dateBadgeHeight = message.isFirstOfDay ? Constant.dateBadgeHeight : 0
        let inset = (Constant.dateBadgeInset + Constant.messageInset) * 2
        return sentMessageTextHeight(of: message.text) + dateBadgeHeight + inset
    }
    
    private func receivedMessageHeight(of message: Message) -> CGFloat {
        let dateBadgeHeight = message.isFirstOfDay ? Constant.dateBadgeHeight : 0
        let inset = message.shouldImageShow ? (Constant.dateBadgeInset + Constant.messageInset) * 2 :
            (Constant.dateBadgeInset + Constant.messageInset)
        let nicknameHeight = message.shouldImageShow ? (Constant.nicknameTextHeight + Constant.nicknameTextInset) : 0
        
        return receivedMessageTextHeight(of: message.text) + dateBadgeHeight + nicknameHeight + inset
    }
    
    private func systemMessageHeight(of message: Message) -> CGFloat {
        let dateBadgeHeight = message.isFirstOfDay ? Constant.dateBadgeHeight : 0
        let inset = message.isFirstOfDay ? Constant.messageInset : Constant.dateBadgeInset
        return Constant.systemMessageCellHeight + dateBadgeHeight + inset
    }
    
    private func translatedMessageHeight(of message: Message) -> CGFloat {
        let inset = Constant.translatedMessageBottomInset
        return receivedMessageTextHeight(of: message.text) + inset
    }
    
    private func sentTranslatedMessageHeight(of message: Message) -> CGFloat {
        let inset = Constant.translatedMessageBottomInset
        return sentMessageTextHeight(of: message.text) + inset
    }
    
    private func sentMessageTextHeight(of text: String) -> CGFloat {
        let maxSize = CGSize(width: 240 - Constant.messageInset * 2,
                             height: CGFloat.greatestFiniteMagnitude)
        let font = UIFont.init(name: "Helvetica", size: 14) ?? UIFont.systemFont(ofSize: 14)
        let textHeight = text.boundingRect(with: maxSize,
                                 options: [.usesLineFragmentOrigin],
                                 attributes: [.font: font],
                                 context: nil).height
        return textHeight + Constant.messageInset * 2 + 1
    }
    
    private func receivedMessageTextHeight(of text: String) -> CGFloat {
        let maxSize = CGSize(width: 200 - Constant.messageInset * 2,
                             height: CGFloat.greatestFiniteMagnitude)
        let font = UIFont.init(name: "Helvetica", size: 14) ?? UIFont.systemFont(ofSize: 14)
        let textHeight = text.boundingRect(with: maxSize,
                                           options: [.usesLineFragmentOrigin],
                                           attributes: [.font: font],
                                           context: nil).height
        return textHeight + Constant.messageInset * 2 + 1
    }
}
