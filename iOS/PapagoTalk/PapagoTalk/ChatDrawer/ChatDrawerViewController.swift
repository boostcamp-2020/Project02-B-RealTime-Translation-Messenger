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
    @IBOutlet private weak var micButtonSettingButton: UIButton!
    private var visualEffectView: UIVisualEffectView
    private var runningAnimations = [UIViewPropertyAnimator]()
    
    var chatDrawerObserver: BehaviorRelay<Bool>
    var buttonSizeObserver: BehaviorRelay<MicButtonSize>
    var completion: (() -> Void)?
    var disposeBag = DisposeBag()
    var currentToast: Toast?
    
    init?(coder: NSCoder,
          reactor: ChatDrawerViewReactor,
          visualEffectView: UIVisualEffectView,
          stateObserver: BehaviorRelay<Bool>,
          buttonSizeObserver: BehaviorRelay<MicButtonSize>) {
        self.visualEffectView = visualEffectView
        self.chatDrawerObserver = stateObserver
        self.buttonSizeObserver = buttonSizeObserver
        super.init(coder: coder)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        self.visualEffectView = UIVisualEffectView()
        self.chatDrawerObserver = BehaviorRelay(value: false)
        self.buttonSizeObserver = BehaviorRelay(value: .small)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
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
                guard let self = self else { return UICollectionViewCell() }
                return self.configureChatDrawerUserCell(at: row, with: element)
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
        
        view.rx.panGesture()
            .subscribe(onNext: { [weak self] in
                self?.chatDrawerPanned(recognizer: $0)
            })
            .disposed(by: disposeBag)
        
        visualEffectView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.chatDrawerObserver.accept(true)
            })
            .disposed(by: disposeBag)
        
        micButtonSettingButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.presentMicButtonSettingActionSheet()
            })
            .disposed(by: disposeBag)
    }
    
    private func presentMicButtonSettingActionSheet() {
        let actionSheetController = UIAlertController(title: "마이크 버튼 설정", message: "마이크 버튼의 크기를 선택해주세요", preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        actionSheetController.addAction(cancelAction)

        let bigAction = UIAlertAction(title: "크게", style: .default) { [weak self] _ in
            self?.buttonSizeObserver.accept(.big)
        }
        actionSheetController.addAction(bigAction)

        let midiumAction = UIAlertAction(title: "중간", style: .default) { [weak self] _ in
            self?.buttonSizeObserver.accept(.midium)
        }
        actionSheetController.addAction(midiumAction)
        
        let smallAction = UIAlertAction(title: "작게", style: .default) { [weak self] _ in
            self?.buttonSizeObserver.accept(.small)
        }
        actionSheetController.addAction(smallAction)
        
        let noneAction = UIAlertAction(title: "사용안함", style: .destructive) { [weak self] _ in
            self?.buttonSizeObserver.accept(.none)
        }
        actionSheetController.addAction(noneAction)

        present(actionSheetController, animated: true, completion: nil)
    }
    
    private func configureChatDrawerUserCell(at row: Int, with element: User) -> UICollectionViewCell {
        guard let cell = userListCollectionView.dequeueReusableCell(withReuseIdentifier: ChatDrawerUserCell.identifier,
                                                                    for: IndexPath(row: row, section: .zero)) as? ChatDrawerUserCell else {
            return UICollectionViewCell()
        }
        cell.configureUserCell(with: element)
        return cell
    }
    
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
    
    private func chatDrawerPanned(recognizer: UIPanGestureRecognizer) {
        guard let superview = view.superview else {
            return
        }
        
        let velocity = recognizer.velocity(in: view)
        let superviewWidth = superview.frame.width
        let viewWidth = view.frame.width
        
        if abs(velocity.x) > abs(velocity.y) {
            let translation = recognizer.translation(in: view)
            var newX = view.center.x + translation.x
            
            if newX + viewWidth/2 < superviewWidth {
                newX = superviewWidth - viewWidth/2
            }
            view.center.x = newX
            recognizer.setTranslation(.zero, in: view)
        }
        
        guard recognizer.state == .ended else {
            return
        }
        
        guard view.center.x + viewWidth/2 > superviewWidth + viewWidth * 0.1 else {
            view.center.x = superviewWidth - viewWidth/2
            return
        }
        chatDrawerObserver.accept(true)
    }
}

extension ChatDrawerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 60)
    }
}
