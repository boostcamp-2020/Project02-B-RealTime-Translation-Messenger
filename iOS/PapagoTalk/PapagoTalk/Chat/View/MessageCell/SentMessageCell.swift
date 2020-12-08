//
//  SentMessageCell.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/27.
//

import UIKit

final class SentMessageCell: UICollectionViewCell {
    
    @IBOutlet private weak var dateBadge: UIButton!
    @IBOutlet private weak var messageTextView: UITextView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet weak var dateBadgeHeight: NSLayoutConstraint!
}

extension SentMessageCell: MessageCell {
    func configureMessageCell(message: Message) {
        configureDate(of: dateBadge, dateBadgeHeight: dateBadgeHeight, with: message.timeStamp, isFirst: message.isFirstOfDay)
        configureMessage(of: messageTextView, with: message.text)
        configureTime(of: timeLabel, with: message.timeStamp, shouldShow: message.shouldTimeShow)
    }
}
