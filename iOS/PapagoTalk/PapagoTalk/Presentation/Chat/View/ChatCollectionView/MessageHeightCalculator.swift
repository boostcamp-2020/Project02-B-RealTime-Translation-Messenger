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
        case .sentOrigin:
            return sentOriginMessageHeight(of: message)
        case .sentTranslated:
            return sentTranslatedMessageHeight(of: message)
        case .receivedOrigin:
            return receivedOriginMessageHeight(of: message)
        case .receivedTranslated:
            return receivedTranslatedMessageHeight(of: message)
        case .system:
            return systemMessageHeight(of: message)
        }
    }
    
    private func sentOriginMessageHeight(of message: Message) -> CGFloat {
        let dateBadgeHeight = message.isFirstOfDay ? Constant.dateBadgeHeight : .zero
        let inset = (Constant.dateBadgeInset + Constant.messageInset) * 2
        return sentMessageTextHeight(of: message.text) + dateBadgeHeight + inset
    }
    
    private func sentTranslatedMessageHeight(of message: Message) -> CGFloat {
        let inset = Constant.translatedMessageBottomInset
        return sentMessageTextHeight(of: message.text) + inset
    }
    
    private func receivedOriginMessageHeight(of message: Message) -> CGFloat {
        let dateBadgeHeight = message.isFirstOfDay ? Constant.dateBadgeHeight : .zero
        let inset = message.shouldImageShow ? (Constant.dateBadgeInset + Constant.messageInset) * 2 :
            (Constant.dateBadgeInset + Constant.messageInset)
        let nicknameHeight = message.shouldImageShow ? (Constant.nicknameTextHeight + Constant.nicknameTextInset) : .zero
        return receivedMessageTextHeight(of: message.text) + dateBadgeHeight + nicknameHeight + inset
    }
    
    private func receivedTranslatedMessageHeight(of message: Message) -> CGFloat {
        let inset = Constant.translatedMessageBottomInset
        return receivedMessageTextHeight(of: message.text) + inset
    }
    
    private func systemMessageHeight(of message: Message) -> CGFloat {
        let dateBadgeHeight = message.isFirstOfDay ? Constant.dateBadgeHeight : .zero
        let inset = message.isFirstOfDay ? Constant.messageInset : Constant.dateBadgeInset
        return Constant.systemMessageCellHeight + dateBadgeHeight + inset
    }
    
    private func sentMessageTextHeight(of text: String) -> CGFloat {
        let maxSize = CGSize(width: 240 - Constant.messageInset * 2, height: CGFloat.greatestFiniteMagnitude)
        let font = UIFont.init(name: "Helvetica", size: 14) ?? UIFont.systemFont(ofSize: 14)
        let textHeight = text.boundingRect(with: maxSize,
                                           options: [.usesLineFragmentOrigin],
                                           attributes: [.font: font],
                                           context: nil).height
        return textHeight + Constant.messageInset * 2 + 1
    }
    
    private func receivedMessageTextHeight(of text: String) -> CGFloat {
        let maxSize = CGSize(width: 200 - Constant.messageInset * 2, height: CGFloat.greatestFiniteMagnitude)
        let font = UIFont.init(name: "Helvetica", size: 14) ?? UIFont.systemFont(ofSize: 14)
        let textHeight = text.boundingRect(with: maxSize,
                                           options: [.usesLineFragmentOrigin],
                                           attributes: [.font: font],
                                           context: nil).height
        return textHeight + Constant.messageInset * 2 + 1
    }
}
