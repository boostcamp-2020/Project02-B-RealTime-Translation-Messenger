//
//  HomeViewController.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/19.
//

import UIKit
import ReactorKit
import RxCocoa

class HomeViewController: UIViewController, StoryboardView {
    
    @IBOutlet weak var nickNameTextField: UITextField!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = HomeReactor()
    }
    
    func bind(reactor: HomeReactor) {
        nickNameTextField.rx.text
            .orEmpty
            .map { Reactor.Action.nickNameChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.nickName }
            .bind(to: nickNameTextField.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isInvalidNickNameLength }
            .do { if $0 { self.nickNameTextField.shake() } }
            .subscribe()
            .disposed(by: disposeBag)
    }
}
