//
//  ReceivedMessageCell.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/27.
//

import UIKit
import Kingfisher

final class ReceivedMessageCell: UICollectionViewCell {
    
    @IBOutlet private weak var dateBadge: UIButton!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nickNameLabel: UILabel!
    @IBOutlet private weak var messageTextView: UITextView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet weak var dateBadgeHeight: NSLayoutConstraint!
    
}

extension ReceivedMessageCell: MessageCell {
    func configureMessageCell(message: Message) {
        configureDate(of: dateBadge, dateBadgeHeight: dateBadgeHeight, with: message.timeStamp, isFirst: message.isFirstOfDay)
        configureImage(with: message.sender.image)
        configureNickName(with: message.sender.nickName)
        configureMessage(of: messageTextView, with: message.text)
        configureTime(of: timeLabel, with: message.timeStamp)
    }
    
    private func configureImage(with imageURL: String) {
        guard let imageURL = try? imageURL.asURL() else {
            return
        }
        profileImageView.kf.setImage(with: imageURL)
    }
    
    private func configureNickName(with nickName: String) {
        nickNameLabel.text = nickName
    }
}
