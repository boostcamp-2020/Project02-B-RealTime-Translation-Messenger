//
//  UIView+.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/24.
//

import UIKit

extension UIView {
    func shake(count: Float = 2, for duration: TimeInterval = 0.15, withTranslation translation: Float = 5) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration / TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}
