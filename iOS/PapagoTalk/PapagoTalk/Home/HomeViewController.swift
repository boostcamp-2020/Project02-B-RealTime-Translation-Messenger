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
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var nickNameTextField: UITextField!
    
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
    }
}
