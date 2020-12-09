//
//  SpeechViewController.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/02.
//

import UIKit
import ReactorKit
import RxCocoa
import Toaster

final class SpeechViewController: UIViewController, StoryboardView {
    
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var originSendButton: UIButton!
    @IBOutlet private weak var translatedSendButton: UIButton!
    @IBOutlet private weak var originTextView: UITextView!
    @IBOutlet private weak var translatedTextView: UITextView!
    @IBOutlet private weak var microphoneButton: SpeechButton!
    
    weak var delegate: SpeechViewDelegate?
    var disposeBag = DisposeBag()
    
    init?(coder: NSCoder, reactor: SpeechViewReactor) {
        super.init(coder: coder)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        bindKeyboard()
    }
    
    func bind(reactor: SpeechViewReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    // MARK: - Input
    private func bindAction(reactor: SpeechViewReactor) {
        microphoneButton.rx.tap
            .map { Reactor.Action.microphoneButtonTapped }
            .do(onNext: { [weak self] _ in
                self?.microphoneButton.isSpeeching.toggle()
            })
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        originTextView.rx.text
            .orEmpty
            .filter { !$0.isEmpty }
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.originTextChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        translatedTextView.rx.text
            .orEmpty
            .filter { !$0.isEmpty }
            .map { Reactor.Action.translatedTextChaged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        originSendButton.rx.tap
            .withLatestFrom(originTextView.rx.text)
            .compactMap { $0 }
            .filter { !$0.isEmpty }
            .map { _ in Reactor.Action.originSendButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        translatedSendButton.rx.tap
            .withLatestFrom(translatedTextView.rx.text)
            .compactMap { $0 }
            .filter { !$0.isEmpty }
            .map { _ in Reactor.Action.translatedSendButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Output
    private func bindState(reactor: SpeechViewReactor) {
        reactor.state.map { $0.speechRecognizedText }
            .distinctUntilChanged()
            .bind(to: originTextView.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.originText }
            .distinctUntilChanged()
            .bind(to: originTextView.rx.text )
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.translatedText }
            .distinctUntilChanged()
            .bind(to: translatedTextView.rx.text )
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isMicrophoneButtonEnable }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                self?.microphoneButton.isEnabled = $0
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.messageDidSend }
            .distinctUntilChanged()
            .filter { $0 }
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss()
            })
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        cancelButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.dismiss()
            })
            .disposed(by: disposeBag)
    }
    
    private func dismiss() {
        guard let superview = view.superview else { return }
        UIView.transition(with: superview,
                          duration: 0.4,
                          options: [.transitionCrossDissolve]) { [weak self] in
            self?.view.removeFromSuperview()
        } completion: { [weak self] _ in
            self?.delegate?.speechViewDidDismiss()
        }
        
        view.removeFromSuperview()
        removeFromParent()
        dismiss(animated: true)
    }
}

extension SpeechViewController: KeyboardProviding {
    private func bindKeyboard() {
        tapToDissmissKeyboard
            .drive()
            .disposed(by: disposeBag)
        
        keyboardWillShow
            .drive(onNext: { [weak self] keyboardFrame in
                guard let self = self, let superView = self.parent as? ChatViewController else { return }
                superView.microphoneButton.isHidden = true
                self.view.frame.origin.y += keyboardFrame.origin.y - self.view.frame.maxY
                UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut) {
                    self.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
        
        keyboardWillHide
            .drive(onNext: { [weak self] _ in
                guard let self = self, let superView = self.parent as? ChatViewController else { return }
                self.view.frame.origin.y = (superView.view.frame.height - Constant.speechViewHeight)/2.0
                UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut) {
                    self.view.layoutIfNeeded()
                    superView.microphoneButton.isHidden = false
                }
            })
            .disposed(by: disposeBag)
    }
}
