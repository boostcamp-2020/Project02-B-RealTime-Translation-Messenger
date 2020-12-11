//
//  SpeechRegcognizerButton.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/02.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

final class MicrophoneButton: RoundShadowButton {
        
    private var latestCenter: CGPoint?
    private var latestCenterForKeyboard: CGPoint?
    private var isKeyboardAppear: Bool = false
    private var bottomBoundWhenKeyboardAppear: CGFloat = 0
    private let disposeBag = DisposeBag()
    
    var mode: MicButtonSize = .small {
        didSet {
            let newSize = CGSize(width: mode.size, height: mode.size)
            frame.size = newSize
            bounds.size = newSize
            updateShadow()
            layoutSubviews()
            setNeedsDisplay()
            
            let image = UIImage(systemName: "mic",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: mode.size/2,
                                                                               weight: .semibold))
            setImage(image, for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureShadow()
        commonInit()
        attachGesture()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureShadow()
        commonInit()
        attachGesture()
    }
    
    init(mode: MicButtonSize, origin: CGPoint) {
        let size = CGSize(width: mode.size, height: mode.size)
        let rect = CGRect(origin: origin, size: size)
        super.init(frame: rect)
        self.mode = mode
        configureShadow()
        commonInit()
        attachGesture()
    }
 
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(ovalIn: rect)
        UIColor.systemGreen.set()
        circlePath.fill()
    }
    
    func moveForSpeech(completion: (() -> Void)?) {
        isUserInteractionEnabled = false
        guard let superview = superview else { return }
        latestCenter = center
        let newY = superview.center.y + superview.frame.height/4 - Constant.speechViewBottomInset  - (frame.height/2) - superview.safeAreaInsets.bottom
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.center = CGPoint(x: superview.center.x, y: newY)
        }
        completion: { [weak self] _ in
            self?.isUserInteractionEnabled = true
            completion?()
        }
    }
    
    func moveToLatest() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            self.center = self.latestCenter ?? self.center
        }
    }
    
    private func commonInit() {
        let image = UIImage(systemName: "mic",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: mode.size/2,
                                                                           weight: .semibold))
        setImage(image, for: .normal)
        tintColor = .white
        contentMode = .center
        imageView?.contentMode = .scaleAspectFit
        buttonColor = .systemGreen
        
        bindKeyboard()
    }
    
    private func attachGesture() {
        rx.panGesture()
              .asDriver()
              .drive(onNext: { [weak self] in
                guard let self = self else { return }
                let translation = $0.translation(in: self)
                self.center = self.movedPosition(by: translation)
                $0.setTranslation(.zero, in: self)
                
                if $0.state == .ended {
                    self.moveButtonToSide()
                }
              })
              .disposed(by: disposeBag)
    }
    
    private func bindKeyboard() {
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .asObservable()
            .compactMap {
                ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            }
            .asDriver(onErrorJustReturn: .zero)
            .drive(onNext: { [unowned self] keyboardFrame in
                self.isKeyboardAppear = true
                self.bottomBoundWhenKeyboardAppear = calculateBottomBound(with: keyboardFrame.origin.y)
                self.keyboardWillAppear(keyboardOriginY: keyboardFrame.minY)
            })
            .disposed(by: disposeBag)
        
        return NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .asObservable()
            .map { _ in Void.self }
            .asDriver(onErrorJustReturn: Void.self)
            .drive(onNext: { [unowned self] _ in
                self.isKeyboardAppear = false
                self.keyboardWillHide()
            })
            .disposed(by: disposeBag)
    }
    
    private func moveButtonToSide() {
        guard let superViewWidth = superview?.bounds.width else {
            return
        }
        let isLeft = center.x < superViewWidth/2
        let nexX = isLeft ? 12 + bounds.width/2 : superViewWidth - 12 - bounds.width/2
        let movedY = center.y
        let newCenter = CGPoint(x: nexX, y: movedY)
        latestCenter = newCenter
        latestCenterForKeyboard = newCenter
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.center = newCenter
        }
    }
    
    private func movedPosition(by translation: CGPoint) -> CGPoint {
        guard let superview = superview else {
            return center
        }
        let newX = translation.x + center.x
        var newY = translation.y + center.y
        
        let topBound = CGFloat(frame.height/2) + superview.safeAreaInsets.top
        let bottomBound = isKeyboardAppear ? bottomBoundWhenKeyboardAppear :
            (superview.frame.height - frame.height/2) - superview.safeAreaInsets.bottom - 50
        newY = (topBound...bottomBound) ~= newY ? newY : center.y
        
        return CGPoint(x: newX, y: newY)
    }
    
    private func keyboardWillAppear(keyboardOriginY: CGFloat) {
        let yBound = calculateBottomBound(with: keyboardOriginY)
        let originCenter = center
        if center.y >= yBound {
            latestCenterForKeyboard = originCenter
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut) { [weak self] in
                self?.center = CGPoint(x: originCenter.x, y: yBound - 10)
            }
        }
    }
    
    private func keyboardWillHide() {
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            self.center = self.latestCenterForKeyboard ?? self.center
        }
    }
    
    private func calculateBottomBound(with keyboardOriginY: CGFloat) -> CGFloat {
        guard let superview = superview else {
            return 300
        }
        return keyboardOriginY - superview.frame.minY - frame.height/2 - 50
    }
}
