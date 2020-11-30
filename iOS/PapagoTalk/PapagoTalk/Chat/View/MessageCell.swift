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
    func configureDate(of dateButton: UIButton, with timeStamp: Date, isFirst: Bool) {
        dateButton.setTitle(convertToDateFormat(of: timeStamp), for: .normal)
        dateButton.isHidden = !isFirst
    }
    
    func configureMessage(of messageTextView: UITextView, with message: String) {
        messageTextView.text = message
    }
    
    func configureTime(of timeLabel: UILabel, with timeStamp: Date) {
        timeLabel.text = convertToTimeFormat(of: timeStamp)
    }
    
    private func convertToDateFormat(of timeStamp: Date) -> String {
        return DateFormatter.chatDateFormat(of: timeStamp)
    }
    
    private func convertToTimeFormat(of timeStamp: Date) -> String {
        return DateFormatter.chatTimeFormat(of: timeStamp)
    }
}
