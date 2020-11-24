//
//  ChatViewController.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/25.
//

import UIKit
import ReactorKit
import RxCocoa

final class ChatViewController: UIViewController, StoryboardView {

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = ChatViewReactor()
    }
    
    func bind(reactor: ChatViewReactor) {

    }
}
