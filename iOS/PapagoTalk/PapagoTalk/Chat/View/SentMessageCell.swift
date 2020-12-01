//
//  SentMessageCell.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/27.
//

import UIKit

final class SentMessageCell: UICollectionViewCell {
    
    @IBOutlet private weak var dateButton: UIButton!
    @IBOutlet private weak var messageTextView: UITextView!
    @IBOutlet private weak var timeLabel: UILabel!
}

extension SentMessageCell: MessageCell {
    func configureMessageCell(message: Message) {
        configureDate(of: dateButton, with: message.timeStamp, isFirst: message.isFirstOfDay)
        configureMessage(of: messageTextView, with: message.text)
        configureTime(of: timeLabel, with: message.timeStamp)
    }
}
