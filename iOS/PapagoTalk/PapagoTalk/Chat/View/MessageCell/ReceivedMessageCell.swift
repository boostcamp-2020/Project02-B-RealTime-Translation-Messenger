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
    @IBOutlet weak var profileImageHeight: NSLayoutConstraint!
    @IBOutlet weak var profileImageTopInset: NSLayoutConstraint!
    @IBOutlet weak var messageTopInset: NSLayoutConstraint!
    
    @IBOutlet weak var messageBubbleTail: ReceivedMessageBubbleTail!
    
}

extension ReceivedMessageCell: MessageCell {
    func configureMessageCell(message: Message) {
        configureDate(of: dateBadge, dateBadgeHeight: dateBadgeHeight, with: message.timeStamp, isFirst: message.isFirstOfDay)
        configureMessage(of: messageTextView, with: message.text)
        configureTime(of: timeLabel, with: message.timeStamp, shouldShow: message.shouldTimeShow)
        configureSenderInfo(image: message.sender.image,
                            nickName: message.sender.nickName,
                            shouldImageShow: message.shouldImageShow)
    }
    
    private func configureSenderInfo(image: String, nickName: String, shouldImageShow: Bool) {
        profileImageHeight.constant = shouldImageShow ? 42 : 0
        profileImageTopInset.constant = shouldImageShow ? 12 : 0
        messageTopInset.constant = shouldImageShow ? 8 : 0
        messageBubbleTail.isHidden = !shouldImageShow
        nickNameLabel.text = nil
        if shouldImageShow {
            configureImage(with: image)
            configureNickName(with: nickName)
        }
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
