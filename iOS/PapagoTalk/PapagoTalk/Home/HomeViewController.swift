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
    
    private var profileImageTapGesture =  UITapGestureRecognizer()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = HomeViewReactor()
        profileImageView.addGestureRecognizer(profileImageTapGesture)
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
    }
}
