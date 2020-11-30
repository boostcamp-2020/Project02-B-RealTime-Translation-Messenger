//
//  SentMessageCell.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/27.
//

import UIKit

final class SentMessageCell: UICollectionViewCell {
    @IBOutlet private weak var messageTextView: UITextView!
    
}

extension SentMessageCell: MessageCell {
    func configureMessageCell(message: Message) {
        messageTextView.text = message.text
    }
}
