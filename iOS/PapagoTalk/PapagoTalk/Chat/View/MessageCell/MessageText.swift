//
//  MessageText.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/01.
//

import UIKit

final class MessageText: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configureInset()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureInset()
    }
    
    private func configureInset() {
        let inset = Constant.messageInset
        textContainerInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}
