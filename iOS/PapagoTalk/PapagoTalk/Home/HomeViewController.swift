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
    
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var disposeBag = DisposeBag()
    var profileImageTapGesture =  UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.addGestureRecognizer(profileImageTapGesture)
        reactor = HomeViewReactor()
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
        
        reactor.state.map { $0.nickName }
            .bind(to: nickNameTextField.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isInvalidNickNameLength }
            .do { if $0 { self.nickNameTextField.shake() } }
            .subscribe()
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.profileImageURL }
            .distinctUntilChanged()
            .compactMap { URL(string: $0) }
            .subscribe(onNext: { [weak self] in
                self?.profileImageView.kf.setImage(with: $0)
            })
            .disposed(by: disposeBag)
    }
}
