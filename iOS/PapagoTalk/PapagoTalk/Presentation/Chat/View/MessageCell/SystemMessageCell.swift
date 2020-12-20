//
//  SystemMessageCell.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/09.
//

import UIKit

final class SystemMessageCell: UICollectionViewCell {
    
    @IBOutlet private weak var dateBadge: UIButton!
    @IBOutlet private weak var systemMessageBadge: UIButton!
    @IBOutlet private weak var dateBadgeHeight: NSLayoutConstraint!
}

extension SystemMessageCell: MessageCell {
    func configureMessageCell(message: Message) {
        configureDate(of: dateBadge, dateBadgeHeight: dateBadgeHeight, with: message.time, isFirst: message.isFirstOfDay)
        systemMessageBadge.setTitle(message.text, for: .normal)
    }
}
