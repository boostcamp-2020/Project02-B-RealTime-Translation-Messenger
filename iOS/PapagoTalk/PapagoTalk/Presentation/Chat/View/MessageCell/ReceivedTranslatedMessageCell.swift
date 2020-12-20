//
//  ReceivedTranslatedMessageCell.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/03.
//

import UIKit

final class ReceivedTranslatedMessageCell: UICollectionViewCell {
    
    @IBOutlet private weak var messageTextLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
}

extension ReceivedTranslatedMessageCell: MessageCell {
    func configureMessageCell(message: Message) {
        configureMessage(of: messageTextLabel, with: message.text)
        configureTime(of: timeLabel, with: message.time, shouldShow: message.shouldTimeShow)
    }
}
