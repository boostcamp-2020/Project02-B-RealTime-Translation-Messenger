//
//  ChatDrawerViewController.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/30.
//

import UIKit
import ReactorKit
import RxCocoa
import Toaster

final class ChatDrawerViewController: UIViewController, StoryboardView {
    
    @IBOutlet private weak var userListCollectionView: UICollectionView!
    @IBOutlet private weak var chatRoomCodeButton: UIButton!
    @IBOutlet private weak var leaveChatRoomButton: UIButton!
    private var visualEffectView: UIVisualEffectView
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterrupted = CGFloat.zero
    
    var completion: (() -> Void)?
    var disposeBag = DisposeBag()
    var currentToast: Toast?
    
    init?(coder: NSCoder, reactor: ChatDrawerViewReactor, visualEffectView: UIVisualEffectView) {
        self.visualEffectView = visualEffectView
        super.init(coder: coder)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        self.visualEffectView = UIVisualEffectView()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        bindChatDrawerGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureAnimation(state: .opened, duration: 0.9)
    }
    
    func bind(reactor: ChatDrawerViewReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    // MARK: - Input
    private func bindAction(reactor: ChatDrawerViewReactor) {
        self.rx.viewWillAppear
            .map { _ in
                Reactor.Action.fetchUsers
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        chatRoomCodeButton.rx.tap
            .map { Reactor.Action.chatRoomCodeButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        leaveChatRoomButton.rx.tap
            .map { Reactor.Action.leaveChatRoomButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Output
    private func bindState(reactor: ChatDrawerViewReactor) {
        reactor.state.map { $0.users }
            .asObservable()
            .bind(to: userListCollectionView.rx.items) { [weak self] (_, row, element) in
                guard let cell = self?.configureChatDrawerUserCell(at: row, with: element) else {
                    return UICollectionViewCell()
                }
                return cell
            }
            .disposed(by: disposeBag)
        
        reactor.state.compactMap { $0.roomCode }
            .distinctUntilChanged()
            .asObservable()
            .subscribe(onNext: {
                UIPasteboard.general.string = $0.data
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.toastMessage }
            .compactMap { $0.data }
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] in
                self?.currentToast?.cancel()
                self?.currentToast = Toast(text: $0, delay: 0, duration: 2)
                self?.currentToast?.show()
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.leaveChatRoom }
            .filter { $0 }
            .do { [weak self] _ in
                self?.dismiss(animated: true, completion: {
                    self?.navigationController?.popViewController(animated: true)
                })
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        userListCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func configureChatDrawerUserCell(at row: Int, with element: User) -> UICollectionViewCell {
        guard let cell = userListCollectionView.dequeueReusableCell(withReuseIdentifier: ChatDrawerUserCell.identifier,
                                                                    for: IndexPath(row: row, section: .zero)) as? ChatDrawerUserCell else {
            return UICollectionViewCell()
        }
        cell.configureUserCell(with: element)
        return cell
    }
    
    // MARK: - configure ChatDrawer
    
    private func bindChatDrawerGesture() {
        view.rx.panGesture()
            .subscribe(onNext: { [weak self] in
                self?.chatDrawerPanned(recognizer: $0)
            })
            .disposed(by: disposeBag)
        
        visualEffectView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.configureAnimation(state: .closed, duration: 0.9)
                
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - ChatDrawer Animation
    
    func configureAnimation(state: ChatDrawerState, duration: TimeInterval) {

        guard runningAnimations.isEmpty else {
            DispatchQueue.main.async { [weak self] in
                self?.runningAnimations.removeAll()
                self?.configureAnimation(state: state, duration: duration)
            }
            return
        }
        
        let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) { [weak self] in
            guard let self = self,
                  let superview = self.parent?.view else {
                return
            }
            switch state {
            case .opened:
                self.view.frame.origin.x = superview.frame.width - self.view.frame.width
            case .closed:
                self.view.frame.origin.x = superview.frame.width
            }
        }
        
        frameAnimator.addCompletion { [weak self] _ in
            self?.runningAnimations.removeAll()
            guard state == .closed else {
                return
            }
            self?.dismiss(animated: false, completion: self?.completion)
            self?.view.removeFromSuperview()
            self?.visualEffectView.removeFromSuperview()
            self?.removeFromParent()
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
            let translation = recognizer.translation(in: view)
            updateInteractiveTransition(fractionCompleted: translation.x / view.frame.width)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    private func startInteractiveTransition(state: ChatDrawerState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            configureAnimation(state: state, duration: duration)
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

extension ChatDrawerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 60)
    }
}
