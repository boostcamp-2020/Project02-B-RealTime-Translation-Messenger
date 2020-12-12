//
//  TranslatedMessageCell.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/03.
//

import UIKit

final class TranslatedMessageCell: UICollectionViewCell {
    @IBOutlet weak var messageTextView: MessageText!
    @IBOutlet weak var timeLabel: UILabel!
}

extension TranslatedMessageCell: MessageCell {
    func configureMessageCell(message: Message) {
        configureMessage(of: messageTextView, with: message.text)
        configureTime(of: timeLabel, with: message.time, shouldShow: message.shouldTimeShow)
    }
}
