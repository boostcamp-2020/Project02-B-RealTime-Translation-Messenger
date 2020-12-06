//
//  SpeechButton.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/06.
//

import UIKit

class SpeechButton: UIButton {
    
    var isSpeeching: Bool = false {
        didSet {
            isSpeeching ? startAnimation() : stopAnimation()
        }
    }
    
    var micLayer: CAShapeLayer?
    var dotLayers: [CAShapeLayer] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func draw(_ rect: CGRect) {
        let circle = UIBezierPath(ovalIn: rect)
        UIColor.white.set()
        circle.fill()
        circle.close()
    }
    
    private func commonInit() {
        let image = UIImage(systemName: "mic",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: frame.width/2,
                                                                           weight: .semibold))
        setImage(image, for: .normal)
        contentMode = .center
        imageView?.contentMode = .scaleAspectFit
        attachMicLayer()
    }
    
    private func attachMicLayer() {
        let micLayer = CAShapeLayer()
        let circle = UIBezierPath(ovalIn: bounds)
        micLayer.fillColor = UIColor.systemGreen.cgColor
        micLayer.strokeColor = UIColor.clear.cgColor
        micLayer.frame = bounds
        micLayer.path = circle.cgPath
        micLayer.position = CGPoint(x: bounds.width/2, y: bounds.height/2)
        layer.addSublayer(micLayer)
        
        self.micLayer = micLayer
        guard let imageView = imageView else { return }
        bringSubviewToFront(imageView)
    }
    
    private func startAnimation() {
        micLayer?.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
        
        imageView?.isHidden = true
        setDotLayers()
        animateDotLayers()
    }
    
    private func stopAnimation() {
        micLayer?.transform = CATransform3DMakeScale(1, 1, 1)
        dotLayers.forEach {
            $0.removeAllAnimations()
            $0.removeFromSuperlayer()
        }
        dotLayers = []
        imageView?.isHidden = false
    }
    
    private func setDotLayers() {
        let center = CGPoint(x: frame.width/2, y: frame.height/2)
        let dotSize: CGFloat = 5
        
        (1...3).forEach {
            let dotPath = UIBezierPath()
            dotPath.move(to: CGPoint(x: center.x/2 * CGFloat($0), y: center.y - dotSize/2))
            dotPath.addLine(to: CGPoint(x: center.x/2 * CGFloat($0), y: center.y + dotSize/2))
            
            let shape = CAShapeLayer()
            shape.lineWidth = dotSize
            shape.fillColor = UIColor.systemGreen.cgColor
            shape.strokeColor = UIColor.systemGreen.cgColor
            shape.lineCap = .round
            shape.frame = bounds
            shape.path = dotPath.cgPath
            shape.position = center
            dotLayers.append(shape)
            layer.addSublayer(shape)
        }
    }
    
    private func animationPath(index: Int) -> UIBezierPath {
        let path = UIBezierPath()
        let random = CGFloat.random(in: (5...8))
        path.move(to: CGPoint(x: frame.width/4 * CGFloat(index + 1), y: frame.height/2 - random))
        path.addLine(to: CGPoint(x: frame.width/4 * CGFloat(index + 1), y: frame.height/2 + random))
        
        return path
    }
    
    private func animateDotLayers() {
        (0...2).forEach {
            let animation = CABasicAnimation(keyPath: "path")
            animation.toValue = animationPath(index: $0).cgPath
            animation.duration = CFTimeInterval(CGFloat.random(in: (0.5...1)))
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            animation.autoreverses = true
            animation.repeatCount = .infinity
            dotLayers[$0].add(animation, forKey: "speeching")
        }
    }
}
