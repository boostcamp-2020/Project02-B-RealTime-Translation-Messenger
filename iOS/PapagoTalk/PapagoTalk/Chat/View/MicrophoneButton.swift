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

final class MicrophoneButton: UIButton {
    
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
    
    private var latestCenter: CGPoint?
    private let disposeBag = DisposeBag()
    
    var mode: ContentsMode = .small {
        didSet {
            let newSize = CGSize(width: mode.size, height: mode.size)
            frame.size = newSize
            bounds.size = newSize
            updateShadow()
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
    
    init(mode: ContentsMode, origin: CGPoint) {
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
        let newY = superview.center.y + Constant.speechViewHeight/2 - Constant.speechViewBottomInset  - (frame.height/2) - superview.frame.minY - 8
        
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
            self?.center = self?.latestCenter ?? .zero
        }
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
            .drive(onNext: { [weak self] keyboardFrame in
                self?.keyboardWillAppear(keyboardOriginY: keyboardFrame.minY)
            })
            .disposed(by: disposeBag)
        
        return NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .asObservable()
            .map { _ in Void.self }
            .asDriver(onErrorJustReturn: Void.self)
            .drive(onNext: { [weak self] _ in
                self?.moveToLatest()
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
        newY = (CGFloat(frame.height/2)...(superview.frame.height - frame.height/2)) ~= newY ? newY : center.y
        
        return CGPoint(x: newX, y: newY)
    }
    
    private func keyboardWillAppear(keyboardOriginY: CGFloat) {
        guard let superview = superview else {
            return
        }
        let yBound = keyboardOriginY - superview.frame.minY - frame.height/2 - 50
        let originCenter = center
        if center.y >= yBound {
            latestCenter = originCenter
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
                self?.center = CGPoint(x: originCenter.x, y: yBound - 10)
            }
        }
    }
}
