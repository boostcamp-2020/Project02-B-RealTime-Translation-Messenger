//
//  SpeechRegcognizerButton.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/02.
//

import UIKit

final class SpeechRegcognizerButton: UIButton {
    
    enum ContentsMode {
        case big
        case midium
        case small
        case none
        
        var size: CGFloat {
            switch self {
            case .big:
                return 70
            case .midium:
                return 70
            case .small:
                return 50
            case .none:
                return 0
            }
        }
    }
    
    @IBInspectable
    var buttonColor: UIColor?
    
    var mode: ContentsMode = .small {
        didSet {
            constraints
                .filter { $0.firstAttribute == .width }[1]
                .constant = mode.size
            superview?.layoutIfNeeded()
            updateShadow()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureShadow()
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureShadow()
        commonInit()
    }
 
    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let offset = rect.width * 0.5 / 2
        
        let circlePath = UIBezierPath(ovalIn: rect)
        (buttonColor ?? UIColor.systemGreen).set()
        circlePath.fill()
        
        let plusPath = UIBezierPath()
        plusPath.move(to: CGPoint(x: center.x - offset, y: center.y))
        plusPath.addLine(to: CGPoint(x: center.x + offset, y: center.y))
        
        plusPath.move(to: CGPoint(x: center.x, y: center.y - offset))
        plusPath.addLine(to: CGPoint(x: center.x, y: center.y + offset))
        plusPath.close()
    }
    
    private func configureShadow() {
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        layer.shadowOffset = CGSize(width: 2, height: 8)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2.0
        layer.masksToBounds = false
        
        updateShadow()
    }
    
    private func updateShadow() {
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.width).cgPath
    }
    
    private func commonInit() {
        let image = UIImage(systemName: "mic",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: mode.size/2,
                                                                           weight: .semibold))
        setImage(image, for: .normal)
        tintColor = .white
        contentMode = .center
        imageView?.contentMode = .scaleAspectFit
    }
}
