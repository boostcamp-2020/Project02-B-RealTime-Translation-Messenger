//
//  JoinChatViewController.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/28.
//

import UIKit
import ReactorKit
import RxCocoa

final class JoinChatViewController: UIViewController, StoryboardView {
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = JoinChatReactor()
    }
    
    func bind(reactor: JoinChatReactor) {
        
    }
}
