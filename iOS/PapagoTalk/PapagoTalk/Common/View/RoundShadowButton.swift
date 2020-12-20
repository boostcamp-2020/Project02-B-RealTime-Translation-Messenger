//
//  RoundShadowButton.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/07.
//

import UIKit

class RoundShadowButton: UIButton {
    
    @IBInspectable
    var buttonColor: UIColor?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureShadow()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureShadow()
    }
 
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(ovalIn: rect)
        (buttonColor ?? UIColor.white).set()
        circlePath.fill()
    }
    
    func configureShadow() {
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        layer.shadowOffset = CGSize(width: 2, height: 3)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2.0
        layer.masksToBounds = false
        updateShadow()
    }
    
    func updateShadow() {
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.width).cgPath
    }
}
