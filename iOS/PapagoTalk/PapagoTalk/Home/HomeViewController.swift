//
//  HomeViewController.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/19.
//

import UIKit
import ReactorKit
import RxCocoa
import RxGesture
import Kingfisher

final class HomeViewController: UIViewController, StoryboardView {
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nickNameTextField: UITextField!
    @IBOutlet private weak var languageSelectionButton: UIButton!
    @IBOutlet private weak var selectedLanguageLabel: UILabel!
    @IBOutlet private weak var joinChatRoomButton: UIButton!
    @IBOutlet private weak var makeChatRoomButton: UIButton!
    @IBOutlet private weak var chatHistoryButton: UIBarButtonItem!
    @IBOutlet private weak var settingButton: UIBarButtonItem!
    
    private var languageSelection: BehaviorSubject<Language>
    private let alertFactory: AlertFactoryProviding
    
    weak var coordinator: HomeCoordinating?
    var disposeBag = DisposeBag()
    
    init?(coder: NSCoder,
          reactor: HomeViewReactor,
          alertFactory: AlertFactoryProviding,
          currentLanguage: Language) {
        
        self.alertFactory = alertFactory
        languageSelection = BehaviorSubject(value: currentLanguage)
        super.init(coder: coder)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        alertFactory = AlertFactory()
        languageSelection = BehaviorSubject(value: Language.english)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nickNameTextField.autocorrectionType = .no
        bind()
        bindKeyboard()
    }
    
    func bind(reactor: HomeViewReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    // MARK: - Input
    private func bindAction(reactor: HomeViewReactor) {
        profileImageView.rx.tapGesture()
            .when(.recognized)
            .map { _ in
                Reactor.Action.profileImageTapped
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        nickNameTextField.rx.text
            .orEmpty
            .changed
            .map { Reactor.Action.nickNameChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        languageSelection
            .map { Reactor.Action.languageSelected($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        makeChatRoomButton.rx.tap
            .map { Reactor.Action.makeChatRoomButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        joinChatRoomButton.rx.tap
            .map { Reactor.Action.joinChatRoomButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Output
    private func bindState(reactor: HomeViewReactor) {
        reactor.state.map { $0.profileImageURL }
            .distinctUntilChanged()
            .compactMap { URL(string: $0) }
            .subscribe(onNext: { [weak self] in
                self?.profileImageView.kf.setImage(with: $0)
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.nickName }
            .bind(to: nickNameTextField.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.needShake }
            .distinctUntilChanged()
            .compactMap { $0.data }
            .filter { $0 }
            .subscribe(onNext: { [weak self] _ in
                self?.nickNameTextField.shake()
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.language }
            .distinctUntilChanged()
            .map { $0.localizedText }
            .bind(to: selectedLanguageLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.compactMap { $0.createRoomResponse }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                self?.coordinator?.pushChat(roomID: $0.roomId, code: $0.code)
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.joinRoom }
            .distinctUntilChanged()
            .compactMap { $0.data }
            .filter { $0 }
            .subscribe(onNext: { [weak self] _ in
                self?.coordinator?.presentCodeInput()
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.errorMessage }
            .distinctUntilChanged()
            .subscribeOn(MainScheduler.instance)
            .compactMap { $0.data }
            .subscribe(onNext: { [weak self] errorMessage in
                guard let message = errorMessage else {
                    return
                }
                self?.alert(message: message)
            })
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        languageSelectionButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.presentLanguageSelectionView()
            }
            .disposed(by: disposeBag)
        
        settingButton.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self] in
                self?.coordinator?.pushSetting()
            })
            .disposed(by: disposeBag)
    }
    
    private func alert(message: String) {
        present(alertFactory.alert(message: message), animated: true)
    }
    
    private func presentLanguageSelectionView() {
        coordinator?.presentLanguageSelectionView(observer: languageSelection)
    }
}

extension HomeViewController: KeyboardProviding {
    private func bindKeyboard() {
        tapToDissmissKeyboard
            .drive()
            .disposed(by: disposeBag)
    }
}
