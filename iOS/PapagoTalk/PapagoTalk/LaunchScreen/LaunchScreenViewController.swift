//
//  LaunchScreenViewController.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/07.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var centerImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    var coordinator: MainCoordinator?
    private var circleLayer: CAShapeLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCircleLayer()
        imageContainerView.layer.masksToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateCircleBigger()
        configureImageStartPoint(imageView: centerImageView)
        configureImageStartPoint(imageView: rightImageView)
        configureImageStartPoint(imageView: leftImageView)
        centerImageJumpAnimation()
        rightImageJumpAnimation()
        leftImageJumpAnimation()
    }
    
    private func configureCircleLayer() {
        let layer = CAShapeLayer()
        let center = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        let circle = UIBezierPath(arcCenter: center,
                                  radius: 1,
                                  startAngle: CGFloat.zero,
                                  endAngle: CGFloat(Double.pi * 2),
                                  clockwise: true)
        layer.fillColor = UIColor.systemYellow.cgColor
        layer.strokeColor = UIColor.clear.cgColor
        layer.frame = view.bounds
        layer.path = circle.cgPath
        layer.position = center
        
        view.layer.addSublayer(layer)
        view.bringSubviewToFront(imageContainerView)
        circleLayer = layer
    }
    
    private func animateCircleBigger() {
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.4)
        circleLayer?.transform = CATransform3DMakeScale(80, 80, 80)
        CATransaction.commit()
    }
    
    private func configureImageStartPoint(imageView: UIImageView) {
        var origin = imageView.frame.origin
        origin.y += 200
        imageView.frame.origin = origin
    }
    
    private func centerImageJumpAnimation() {
        var origin = centerImageView.frame.origin
        origin.y -= 220
        UIView.animate(withDuration: 0.5, delay: 0.4, options: .curveEaseInOut) { [weak self] in
            self?.centerImageView.frame.origin = origin
        } completion: { [weak self] _ in
            self?.centerDownAnimation()
        }
    }
    
    private func centerDownAnimation() {
        var origin = centerImageView.frame.origin
        origin.y += 20
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.centerImageView.frame.origin = origin
        }
    }
    
    private func rightImageJumpAnimation() {
        var origin = rightImageView.frame.origin
        origin.y -= 220
        UIView.animate(withDuration: 0.5, delay: 0.6, options: .curveEaseInOut) { [weak self] in
            self?.rightImageView.frame.origin = origin
        } completion: { [weak self] _ in
            self?.rightDownAnimation()
        }
    }
    
    private func rightDownAnimation() {
        var origin = rightImageView.frame.origin
        origin.y += 20
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.rightImageView.frame.origin = origin
        }
    }
    
    private func leftImageJumpAnimation() {
        var origin = leftImageView.frame.origin
        origin.y -= 220
        UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseInOut) { [weak self] in
            self?.leftImageView.frame.origin = origin
        } completion: { [weak self] _ in
            self?.leftDownAnimation()
        }
    }
    
    private func leftDownAnimation() {
        var origin = leftImageView.frame.origin
        origin.y += 20
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.leftImageView.frame.origin = origin
        } completion: { [weak self] _ in
            self?.finishingAnimation()
        }
    }

    private func finishingAnimation() {
        downscaleImage()
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.4)
        circleLayer?.transform = CATransform3DMakeScale(1/2, 1/2, 1/2)
        CATransaction.commit()
    }
    
    private func downscaleImage() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.imageContainerView.transform = CGAffineTransform(scaleX: 1/150, y: 1/150)
        } completion: { [weak self] _ in
            self?.moveToHome()
        }
      
    }
    
    private func moveToHome() {
        view.window?.rootViewController = coordinator?.navigationController
    }
}
