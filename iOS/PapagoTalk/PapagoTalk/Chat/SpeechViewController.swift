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
    @IBOutlet private weak var microphoneButton: UIButton!
    
    weak var delegate: SpeechViewDelegate?
    let papago = PapagoAPIManager() //
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = SpeechViewReactor()
        bind()
    }
    
    func bind(reactor: SpeechViewReactor) {
        microphoneButton.rx.tap
            .map { Reactor.Action.microphoneButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        originTextView.rx.text
            .orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .do(onNext: { [weak self] in
                self?.papago.requestTranslation(request: TranslationRequest(source: "ko",
                                                                           target: "en",
                                                                           text: $0)) { result in
                    DispatchQueue.main.async {
                        self?.translatedTextView.text = result
                    }
                }
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.speechRecognizedText }
            .distinctUntilChanged()
            .bind(to: originTextView.rx.text)
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
