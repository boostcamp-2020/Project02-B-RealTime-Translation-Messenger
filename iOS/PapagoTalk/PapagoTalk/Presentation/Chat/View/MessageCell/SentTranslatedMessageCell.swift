//
//  SentTranslatedMessageCell.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/10.
//

import UIKit

final class SentTranslatedMessageCell: UICollectionViewCell {
    
    @IBOutlet private weak var messageTextLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
}

extension SentTranslatedMessageCell: MessageCell {
    func configureMessageCell(message: Message) {
        configureMessage(of: messageTextLabel, with: message.text)
        configureTime(of: timeLabel, with: message.time, shouldShow: message.shouldTimeShow)
    }
}
