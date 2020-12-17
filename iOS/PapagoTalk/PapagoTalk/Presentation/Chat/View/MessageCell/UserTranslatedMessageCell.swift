//
//  UserTranslatedMessageCell.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/10.
//

import UIKit

final class UserTranslatedMessageCell: UICollectionViewCell {
    
    @IBOutlet weak var messageTextLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
}

extension UserTranslatedMessageCell: MessageCell {
    func configureMessageCell(message: Message) {
        configureMessage(of: messageTextLabel, with: message.text)
        configureTime(of: timeLabel, with: message.time, shouldShow: message.shouldTimeShow)
    }
}
