//
//  SentMessageCell.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/27.
//

import UIKit

final class SentMessageCell: UICollectionViewCell {
    
    @IBOutlet private weak var dateBadge: UIButton!
    @IBOutlet weak var messageTextLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet weak var dateBadgeHeight: NSLayoutConstraint!
}

extension SentMessageCell: MessageCell {
    func configureMessageCell(message: Message) {
        configureDate(of: dateBadge, dateBadgeHeight: dateBadgeHeight, with: message.time, isFirst: message.isFirstOfDay)
        configureMessage(of: messageTextLabel, with: message.text)
        configureTime(of: timeLabel, with: message.time, shouldShow: message.shouldTimeShow)
    }
}
