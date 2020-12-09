//
//  SystemMessageCell.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/09.
//

import UIKit

class SystemMessageCell: UICollectionViewCell {
    @IBOutlet weak var systemMessageBadge: UIButton!
}

extension SystemMessageCell: MessageCell {
    func configureMessageCell(message: Message) {
        systemMessageBadge.setTitle(message.text, for: .normal)
    }
}
