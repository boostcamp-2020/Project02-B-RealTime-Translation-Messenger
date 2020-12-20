//
//  ReceivedOriginMessageCell.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/27.
//

import UIKit
import Kingfisher

final class ReceivedOriginMessageCell: UICollectionViewCell {
    
    @IBOutlet private weak var dateBadge: UIButton!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nickNameLabel: UILabel!
    @IBOutlet private weak var messageTextLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var dateBadgeHeight: NSLayoutConstraint!
    @IBOutlet private weak var profileImageHeight: NSLayoutConstraint!
    @IBOutlet private weak var profileImageTopInset: NSLayoutConstraint!
    @IBOutlet private weak var messageTopInset: NSLayoutConstraint!
    @IBOutlet private weak var messageBubbleTail: ReceivedMessageBubbleTail!
}

extension ReceivedOriginMessageCell: MessageCell {
    func configureMessageCell(message: Message) {
        configureDate(of: dateBadge, dateBadgeHeight: dateBadgeHeight, with: message.time, isFirst: message.isFirstOfDay)
        configureMessage(of: messageTextLabel, with: message.text)
        configureTime(of: timeLabel, with: message.time, shouldShow: message.shouldTimeShow)
        configureSenderInfo(message: message)
    }
    
    private func configureSenderInfo(message: Message) {
        let shouldImageShow = message.shouldImageShow
        profileImageHeight.constant = shouldImageShow ? Constant.profileImageHeight : .zero
        profileImageTopInset.constant = shouldImageShow ? Constant.profileImageTopInset : .zero
        messageTopInset.constant = shouldImageShow ? Constant.messageInset : .zero
        messageBubbleTail.isHidden = !shouldImageShow
        nickNameLabel.text = nil
        
        guard shouldImageShow else {
            return
        }
        configureImage(with: message.sender.image)
        configureNickName(with: message.sender.nickName)
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
