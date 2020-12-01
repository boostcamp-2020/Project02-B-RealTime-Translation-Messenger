//
//  ChatDrawerViewController.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/30.
//

import UIKit
import ReactorKit
import RxCocoa

final class ChatDrawerViewController: UIViewController, StoryboardView {
    
    @IBOutlet private weak var userListCollectionView: UICollectionView!
    @IBOutlet private weak var chatRoomCodeButton: UIButton!
    @IBOutlet private weak var leaveChatRoomButton: UIButton!
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewSize()
        reactor = ChatDrawerViewReactor()
    }
    
    func bind(reactor: ChatDrawerViewReactor) {
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
    
    private func configureViewSize() {
        
    }
    
    // view did load -> view 크기 계산 + Animation + 흐림 Effect
    // tap gesture, pan gesture
}
