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

final class ChatViewController: UIViewController, StoryboardView {
    
    @IBOutlet private weak var inputBarTextView: UITextView!
    @IBOutlet private weak var inputBarTextViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var chatCollectionView: UICollectionView!
    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var chatDrawerButton: UIBarButtonItem!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    
    private weak var chatDrawerViewController: ChatDrawerViewController!
    private let chatDrawerBehaviorRelay = BehaviorRelay(value: false)
    private var chatDrawerWidth: CGFloat!
    private var visualEffectView: UIVisualEffectView!
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterrupted = CGFloat.zero
    
    weak var coordinator: MainCoordinator?
    var microphoneButton: MicrophoneButton!
    var disposeBag = DisposeBag()
    
    init?(coder: NSCoder, reactor: ChatViewReactor) {
        super.init(coder: coder)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attachMicrophoneButton()
        bind()
        bindKeyboard()
    }
    
    func bind(reactor: ChatViewReactor) {
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.subscribeNewMessages }
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
            .map { Reactor.Action.chatDrawerButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        chatDrawerBehaviorRelay.filter { $0 }
            .map { _ in Reactor.Action.chatDrawerButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.roomCode }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                var code = $0
                code.insert("-", at: code.index(code.startIndex, offsetBy: 3))
                self?.navigationItem.title = code
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.messageBox.messages }
            .do(afterNext: { [weak self] in
                guard let currentMessageType = $0.last?.type,
                      currentMessageType == .sent else {
                    return
                }
                self?.scrollToLastMessage()
            })
            .bind(to: chatCollectionView.rx.items) { [weak self] (_, row, element) in
                guard let cell = self?.configureChatMessageCell(at: row, with: element) else {
                    return UICollectionViewCell()
                }
                return cell
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.sendResult }
            .asObservable()
            .subscribe()
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.toggleDrawer }
            .distinctUntilChanged()
            .do { [weak self] _ in
                if !(self?.runningAnimations.isEmpty ?? true) {
                    self?.runningAnimations.removeAll()
                }
            }
            .subscribe(onNext: { [weak self] in
                ($0.drawerState) ?
                    self?.configureChatDrawer(roomID: $0.roomID) : self?.configureAnimation(state: .closed, duration: 0.5)
                self?.inputBarTextView.resignFirstResponder()
            })
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        chatCollectionView.rx.setDelegate(self)
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
        
        microphoneButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.microphoneButton.moveForSpeech {
                    self?.showSpeechView()
                }
                //self?.showSpeechView()
            })
            .disposed(by: disposeBag)
    }
    
    private func calculateTextViewHeight(with text: String) -> CGFloat {
        let size = inputBarTextView.sizeThatFits(CGSize(width: inputBarTextView.bounds.size.width,
                                                        height: CGFloat.greatestFiniteMagnitude))
        return min(Constant.inputBarTextViewMaxHeight, size.height)
    }
    
    private func configureChatMessageCell(at row: Int, with element: Message) -> UICollectionViewCell {
        guard let cell = chatCollectionView.dequeueReusableCell(withReuseIdentifier: element.type.identifier,
                                                                for: IndexPath(row: row, section: .zero)) as? MessageCell else {
            return UICollectionViewCell()
        }
        cell.configureMessageCell(message: element)
        return cell
    }
    
    private func scrollToLastMessage() {
        let newY = chatCollectionView.contentSize.height - chatCollectionView.bounds.height
        chatCollectionView.setContentOffset(CGPoint(x: 0, y: newY < 0 ? 0 : newY), animated: true)
    }
    
    // MARK: - configure ChatDrawer
    
    private func configureChatDrawer(roomID: Int) {
        guard chatDrawerViewController == nil else {
            return
        }
        configureVisualEffectView()
        chatDrawerViewController = coordinator?.showChatDrawer(roomID: roomID, roomCode: "")
        addChild(chatDrawerViewController)
        view.addSubview(chatDrawerViewController.view)
        
        chatDrawerWidth = (view.frame.width * 3) / 4
        chatDrawerViewController.view.frame = CGRect(x: view.frame.width,
                                                     y: .zero,
                                                     width: chatDrawerWidth,
                                                     height: view.frame.height)
        chatDrawerViewController.view.clipsToBounds = true
        bindChatDrawerGesture()
        configureAnimation(state: .opened, duration: 0.9)
    }
    
    private func configureVisualEffectView() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = view.frame
        view.addSubview(visualEffectView)
    }
    
    private func bindChatDrawerGesture() {
        chatDrawerViewController
            .view.rx.panGesture()
            .subscribe(onNext: { [weak self] in
                self?.chatDrawerPanned(recognizer: $0)
            })
            .disposed(by: disposeBag)
        
        visualEffectView.rx.tapGesture()
            .when(.recognized)
            .do { _ in
                self.chatDrawerBehaviorRelay.accept(true)
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    // MARK: - ChatDrawer Animation
    
    private func configureAnimation(state: ChatDrawerState, duration: TimeInterval) {
        guard runningAnimations.isEmpty else {
            DispatchQueue.main.async { [weak self] in
                self?.runningAnimations.removeAll()
                self?.configureAnimation(state: state, duration: duration)
            }
            return
        }
        
        let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) { [weak self] in
            guard let self = self, let chatDrawer = self.chatDrawerViewController else {
                return
            }
            switch state {
            case .opened:
                chatDrawer.view.frame.origin.x = self.view.frame.width - self.chatDrawerWidth
            case .closed:
                chatDrawer.view.frame.origin.x = self.view.frame.width
            }
        }
        frameAnimator.addCompletion { [weak self] _ in
            self?.runningAnimations.removeAll()
            guard let chatDrawer = self?.chatDrawerViewController, state == .closed else {
                return
            }
            chatDrawer.dismiss(animated: false, completion: nil)
            chatDrawer.view.removeFromSuperview()
            chatDrawer.removeFromParent()
            self?.chatDrawerViewController = nil
        }
        frameAnimator.startAnimation()
        runningAnimations.append(frameAnimator)
        
        let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) { [weak self] in
            guard let visualEffectView = self?.visualEffectView else {
                return
            }
            switch state {
            case .opened:
                visualEffectView.effect = UIBlurEffect(style: .dark)
                visualEffectView.alpha = 0.3
            case .closed:
                visualEffectView.removeFromSuperview()
                visualEffectView.effect = nil
            }
        }
        blurAnimator.startAnimation()
        runningAnimations.append(blurAnimator)
    }
    
    // MARK: - ChatDrawer PanGesture
    
    private func chatDrawerPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: .closed, duration: 0.5)
        case .changed:
            let translation = recognizer.translation(in: chatDrawerViewController.view)
            updateInteractiveTransition(fractionCompleted: translation.x / chatDrawerWidth)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    private func startInteractiveTransition(state: ChatDrawerState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            chatDrawerBehaviorRelay.accept(true)
        }
        runningAnimations.forEach({
            $0.pauseAnimation()
            animationProgressWhenInterrupted = $0.fractionComplete
        })
    }
    
    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        runningAnimations.forEach({
            $0.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        })
    }
    
    private func continueInteractiveTransition() {
        runningAnimations.forEach({
            $0.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        })
    }
}

extension ChatViewController: KeyboardProviding {
    private func bindKeyboard() {
        tapToDissmissKeyboard
            .drive()
            .disposed(by: disposeBag)
        
        keyboardWillShow
            .drive(onNext: { [weak self] keyboardFrame in
                guard let self = self else {
                    return
                }
                self.bottomConstraint.constant = keyboardFrame.height - self.view.safeAreaInsets.bottom
                UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut) {
                    self.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
        
        keyboardWillHide
            .drive(onNext: { [weak self] _ in
                self?.bottomConstraint.constant = 0
                UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut) {
                    self?.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
    }
}

// TODO: Rx로 수정
extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 40)
    }
}
