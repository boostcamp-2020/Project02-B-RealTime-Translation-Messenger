//
//  MessageCell.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/30.
//

import UIKit

protocol MessageCell: UICollectionViewCell {
    func configureMessageCell(message: Message)
}

extension MessageCell {
    func configureDate(of dateBadge: UIButton, dateBadgeHeight: NSLayoutConstraint, with timeStamp: Date, isFirst: Bool) {
        dateBadge.setTitle(convertToDateFormat(of: timeStamp), for: .normal)
        dateBadge.isHidden = !isFirst
        dateBadgeHeight.constant = isFirst ? Constant.dateBadgeHeight : 0
    }
    
    func configureMessage(of messageLabel: UILabel, with message: String) {
        messageLabel.text = message
        messageLabel.textColor = UIColor.init(named: "MessageTextColor")
    }
    
    func configureTime(of timeLabel: UILabel, with timeStamp: Date, shouldShow: Bool) {
        timeLabel.text = shouldShow ? convertToTimeFormat(of: timeStamp) : nil
    }
    
    private func convertToDateFormat(of timeStamp: Date) -> String {
        return DateFormatter.chatDateFormat(of: timeStamp)
    }
    
    private func convertToTimeFormat(of timeStamp: Date) -> String {
        return DateFormatter.chatTimeFormat(of: timeStamp)
    }
}
