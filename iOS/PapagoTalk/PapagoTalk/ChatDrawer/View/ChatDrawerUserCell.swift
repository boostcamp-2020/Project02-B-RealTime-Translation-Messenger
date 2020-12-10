//
//  ChatDrawerUserCell.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/30.
//

import UIKit
import Kingfisher

final class ChatDrawerUserCell: UICollectionViewCell {
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nickNameLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    
    func configureUserCell(with user: User) {
        configureImage(with: user.image)
        configureNickName(by: user.nickName, with: user.isMe)
        configureLanguage(by: user.language)
    }
    
    private func configureImage(with imageURL: String) {
        guard let imageURL = try? imageURL.asURL() else {
            return
        }
        profileImageView.kf.setImage(with: imageURL)
    }
    
    private func configureNickName(by nickName: String, with isMe: Bool) {
        var text = nickName + "  "
        text += (isMe) ? Strings.ChatDrawer.userIsMe : ""
        nickNameLabel.text = text
    }
    
    private func configureLanguage(by language: Language) {
        languageLabel.text = language.localizedText
    }
}
