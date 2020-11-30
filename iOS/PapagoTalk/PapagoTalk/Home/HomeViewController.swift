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
    
    private var languageSelection = BehaviorSubject(value: user.language)
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = HomeViewReactor()
        bind()
    }
    
    func bind(reactor: HomeViewReactor) {

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
        
//        joinChatRoomButton.rx.tap
//            .map { Reactor.Action. }
        
//        makeChatRoomButton.rx.tap
//            .map { Reactor.Action. }
        
        reactor.state.map { $0.profileImageURL }
            .distinctUntilChanged()
            .compactMap { URL(string: $0) }
            .subscribe(onNext: { [weak self] in
                self?.profileImageView.kf.setImage(with: $0)
                HomeViewController.user.image = $0.absoluteString
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.nickName }
            .do { HomeViewController.user.nickName = $0 }
            .bind(to: nickNameTextField.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isInvalidNickNameLength }
            .filter { $0 }
            .do { [weak self] _ in
                self?.nickNameTextField.shake()
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.language }
            .distinctUntilChanged()
            .do { HomeViewController.user.language = $0 }
            .map { $0.localizedText }
            .bind(to: selectedLanguageLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        languageSelectionButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.showLanguageSelectionView()
            }
            .disposed(by: disposeBag)
    }
    
    private func showLanguageSelectionView() {
        let customAlertView =
            storyboard?.instantiateViewController(identifier: LanguageSelectionView.identifier)
            as? LanguageSelectionView
        customAlertView?.pickerViewObserver = languageSelection
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alertController.setValue(customAlertView, forKey: "contentViewController")
        present(alertController, animated: true)
    }
}
