//
//  SentOriginMessageCell.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/27.
//

import UIKit

final class SentOriginMessageCell: UICollectionViewCell {
    
    @IBOutlet private weak var dateBadge: UIButton!
    @IBOutlet private weak var messageTextLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var dateBadgeHeight: NSLayoutConstraint!
}

extension SentOriginMessageCell: MessageCell {
    func configureMessageCell(message: Message) {
        configureDate(of: dateBadge, dateBadgeHeight: dateBadgeHeight, with: message.time, isFirst: message.isFirstOfDay)
        configureMessage(of: messageTextLabel, with: message.text)
        configureTime(of: timeLabel, with: message.time, shouldShow: message.shouldTimeShow)
    }
}
