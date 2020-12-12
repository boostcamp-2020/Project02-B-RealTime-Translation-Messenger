//
//  HistoryCell.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/13.
//

import UIKit
import Kingfisher

class HistoryCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reEnterButton: UIButton!
    
    
    func configure(with history: ChatRoomHistory) {
        configureImage(with: history.usedImage)
        titleLabel.text = history.title
        nicknameLabel.text = history.usedNickname
        languageLabel.text = history.usedLanguage.localizedText
        dateLabel.text = DateFormatter.chatDateFormat(of: history.enterDate)
    }
    
    private func configureImage(with imageURL: String) {
        guard let imageURL = try? imageURL.asURL() else {
            return
        }
        profileImageView.kf.setImage(with: imageURL)
    }
}
