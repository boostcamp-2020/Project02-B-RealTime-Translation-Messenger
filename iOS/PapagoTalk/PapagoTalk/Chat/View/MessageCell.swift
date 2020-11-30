//
//  MessageCell.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/30.
//

import UIKit

protocol MessageCell: class {
    func configureMessageCell(message: Message)
}
