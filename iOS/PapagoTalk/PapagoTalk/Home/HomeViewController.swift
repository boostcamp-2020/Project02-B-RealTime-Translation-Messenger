//
//  HomeViewController.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/19.
//

import UIKit
import ReactorKit
import RxCocoa
import Kingfisher

final class HomeViewController: UIViewController, StoryboardView {
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nickNameTextField: UITextField!
    @IBOutlet private weak var languageSelectionButton: UIButton!
    @IBOutlet private weak var selectedLanguageLabel: UILabel!
    
    private var profileImageTapGesture =  UITapGestureRecognizer()
    private var languageSelection: BehaviorSubject<Language> = BehaviorSubject(value: Locale.currentLanguage)
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = HomeViewReactor()
        profileImageView.addGestureRecognizer(profileImageTapGesture)
        bind()
    }
    
    func bind(reactor: HomeViewReactor) {
        nickNameTextField.rx.text
            .orEmpty
            .map { Reactor.Action.nickNameChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        profileImageTapGesture.rx.event
            .map { _ in Reactor.Action.profileImageTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        languageSelection
            .map { Reactor.Action.languageSelected($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.nickName }
            .bind(to: nickNameTextField.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isInvalidNickNameLength }
            .filter { $0 }
            .do {  _ in self.nickNameTextField.shake()  }
            .subscribe()
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.profileImageURL }
            .distinctUntilChanged()
            .compactMap { URL(string: $0) }
            .subscribe(onNext: { [weak self] in
                self?.profileImageView.kf.setImage(with: $0)
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.language }
            .distinctUntilChanged()
            .bind(to: selectedLanguageLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func bind() {
        languageSelectionButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.showLanguageSelectionView()
            }
            .disposed(by: disposeBag)
    }
    
    private func showLanguageSelectionView() {
        let customAlertView = storyboard?.instantiateViewController(identifier: LanguageSelectionView.identifier) as? LanguageSelectionView
        customAlertView?.pickerViewObserver = languageSelection
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alertController.setValue(customAlertView, forKey: "contentViewController")
        self.present(alertController, animated: true)
    }
}
