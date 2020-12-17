//
//  LanguagePickerView.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/17.
//

import UIKit

final class LanguagePickerView: UIPickerView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        guard subviews.count > 1 else {
            return
        }
        subviews[1].backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 1, alpha: 0)
        subviews[1].layer.borderWidth = 2
        subviews[1].layer.borderColor = UIColor(named: "PapagoBlue")?.cgColor
    }
}
