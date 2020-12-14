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
    
    var buttonHandler: (() -> Void)?
    
    func configure(with history: ChatRoomHistory) {
        configureImage(with: history.usedImage)
        titleLabel.text = history.title
        nicknameLabel.text = history.usedNickname
        languageLabel.text = history.usedLanguage.localizedText
        configureDateLabel(by: history.enterDate)
    }
    
    private func configureImage(with imageURL: String) {
        guard let imageURL = try? imageURL.asURL() else {
            return
        }
        profileImageView.kf.setImage(with: imageURL)
    }
    
    private func configureDateLabel(by date: Date) {
        var type: TimeFormatType
        
        switch date {
        case date where Calendar.isToday(of: date):
            type = .time
        case date where Calendar.isYesterday(of: date):
            type = .yesterday
        case date where Calendar.isSameYear(of: date):
            type = .date
        default:
            type = .fullDate
        }
        dateLabel.text = DateFormatter.chatHistoryTimeFormat(of: date, type: type)
    }
    
    @IBAction func reEnterButtonTapped(_ sender: UIButton) {
        buttonHandler?()
    }
}
