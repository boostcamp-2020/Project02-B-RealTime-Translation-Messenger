//
//  ChatViewController.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/25.
//

import UIKit
import ReactorKit
import RxCocoa
import RxGesture
import RxDataSources

final class ChatViewController: UIViewController, StoryboardView {
    
    @IBOutlet weak var inputBarTextView: UITextView!
    @IBOutlet private weak var inputBarTextViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var chatCollectionView: ChatCollectionView!
    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatDrawerButton: UIBarButtonItem!
    
    private var chatDrawerObserver = BehaviorRelay(value: false)
    private var micButtonSizeObserver: BehaviorRelay<MicButtonSize>
    private let messageDataSource = MessageDataSource()
    private let messageCollectionViewLayout = MessageSizeDelegate()
    private var isKeyboardShowing: Bool = false
    weak var coordinator: ChatCoordinating?
    var microphoneButton: MicrophoneButton!
    var disposeBag = DisposeBag()
    
    init?(coder: NSCoder, reactor: ChatViewReactor, micButtonObserver: BehaviorRelay<MicButtonSize>) {
        self.micButtonSizeObserver = micButtonObserver
        super.init(coder: coder)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        self.micButtonSizeObserver = BehaviorRelay(value: .small)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        bindKeyboard()
    }
    
    func bind(reactor: ChatViewReactor) {
        attachMicrophoneButton()
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    // MARK: - Input
    private func bindAction(reactor: ChatViewReactor) {
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.subscribeChatRoom }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(UIApplication.willEnterForegroundNotification)
            .asObservable()
            .map { _ in Reactor.Action.fetchMissingMessages }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        sendButton.rx.tap
            .withLatestFrom(inputBarTextView.rx.text)
            .compactMap { $0 }
            .filter { !$0.isEmpty }
            .map { Reactor.Action.sendMessage($0) }
            .do(afterNext: { [weak self] _ in
                self?.inputBarTextView.text = nil
            })
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        chatDrawerButton.rx.tap
            .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance)
            .map { Reactor.Action.chatDrawerButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        chatDrawerObserver.filter { $0 }
            .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance)
            .map { _ in Reactor.Action.chatDrawerButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        micButtonSizeObserver
            .distinctUntilChanged()
            .map { Reactor.Action.micButtonSizeChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Output
    private func bindState(reactor: ChatViewReactor) {        
        reactor.state.map { $0.roomTitle }
            .distinctUntilChanged()
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.messageBox.messages }
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] in
                self?.messageCollectionViewLayout.updateSizes(messages: $0)
            },
            afterNext: { [weak self] _ in
                self?.chatCollectionView.scrollToLast()
            })
            .map { [MessageSection(items: $0)] }
            .bind(to: chatCollectionView.rx.items(dataSource: messageDataSource))
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.sendResult }
            .asObservable()
            .subscribe()
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.presentDrawer }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                self?.setDrawer(isPresent: $0)
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.micButtonSize }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                self?.microphoneButton.mode = $0
            })
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        chatCollectionView.rx.setDelegate(messageCollectionViewLayout)
            .disposed(by: disposeBag)
        
        inputBarTextView.rx.text
            .orEmpty
            .compactMap { [weak self] text in
                self?.calculateTextViewHeight(with: text)
            }
            .asObservable()
            .distinctUntilChanged()
            .bind(to: inputBarTextViewHeight.rx.constant)
            .disposed(by: disposeBag)
        
        microphoneButton?.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.hideKeyboard()
                self?.chatDrawerButton.isEnabled = false
                self?.inputBarTextView.isUserInteractionEnabled = false
                self?.microphoneButton?.moveForSpeech {
                    self?.presentSpeech()
                }
            })
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(.speechViewDidDismiss)
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.chatDrawerButton.isEnabled = true
                self?.inputBarTextView.isUserInteractionEnabled = true
                self?.microphoneButton.moveToLatest()
            })
            .disposed(by: disposeBag)
    }
    
    private func calculateTextViewHeight(with text: String) -> CGFloat {
        let size = inputBarTextView.sizeThatFits(CGSize(width: inputBarTextView.bounds.size.width,
                                                        height: CGFloat.greatestFiniteMagnitude))
        return min(Constant.inputBarTextViewMaxHeight, size.height)
    }
    
    private func presentSpeech() {
        hideKeyboard()
        coordinator?.presentSpeech(from: self)
    }
    
    private func setDrawer(isPresent: Bool) {
        if isPresent {
            hideKeyboard()
        }
        isPresent ? coordinator?.presentDrawer(from: self,
                                               with: chatDrawerObserver,
                                               micButtonSizeObserver: micButtonSizeObserver) : dismissDrawer()
    }
    
    private func dismissDrawer() {
        chatDrawerButton.isEnabled = false
        guard let drawer = children.first as? ChatDrawerViewController else {
            chatDrawerButton.isEnabled = true
            return
        }
        drawer.configureAnimation(state: .closed, duration: 0.5)
    }
    
    private func hideKeyboard() {
        inputBarTextView.resignFirstResponder()
    }
    
    private func attachMicrophoneButton() {
        let origin = CGPoint(x: view.frame.width - 80, y: view.frame.height - 200)
        microphoneButton = MicrophoneButton(mode: .small, origin: origin)
        view.addSubview(microphoneButton)
    }
}

extension ChatViewController: KeyboardProviding {
    private func bindKeyboard() {
        tapToDissmissKeyboard
            .drive()
            .disposed(by: disposeBag)
        
        keyboardWillShow
            .drive(onNext: { [weak self] keyboardFrame in
                guard let self = self,
                      !self.isKeyboardShowing else {
                    return
                }
                self.bottomConstraint.constant = keyboardFrame.height - self.view.safeAreaInsets.bottom
                UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut) {
                    self.view.layoutIfNeeded()
                }
                self.chatCollectionView.keyboardWillShow(keyboardHeight: keyboardFrame.height)
                self.isKeyboardShowing = true
            })
            .disposed(by: disposeBag)
        
        keyboardWillHide
            .drive(onNext: { [weak self] keyboardFrame in
                guard self?.isKeyboardShowing ?? false else {
                    return
                }
                self?.chatCollectionView.keyboardWillHide(keyboardHeight: keyboardFrame.height)
                self?.bottomConstraint.constant = 0
                UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut) {
                    self?.view.layoutIfNeeded()
                }
                self?.isKeyboardShowing = false
            })
            .disposed(by: disposeBag)
    }
}
