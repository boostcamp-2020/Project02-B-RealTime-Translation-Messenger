//
//  InputBarTextView.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/01.
//

import UIKit

final class InputBarTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configureInset()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureInset()
    }
    
    private func configureInset() {
        textContainerInset = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
    }
}
