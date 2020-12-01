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
        
        reactor.state.map { $0.users }
            .asObservable()
            .bind(to: userListCollectionView.rx.items) { [weak self] (_, row, element) in
                guard let cell = self?.configureChatDrawerUserCell(at: row, with: element) else {
                    return UICollectionViewCell()
                }
                return cell
            }
            .disposed(by: disposeBag)
        
        // reactor.state.map { $0.roomCode }
        
        reactor.state.map { $0.leaveChatRoom }
            .filter { $0 }
            .do { [weak self] _ in
                // TODO: coordinator완성된 후 수정
                self?.dismiss(animated: true, completion: {
                    self?.navigationController?.popViewController(animated: true)
                })
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func configureViewSize() {
        
    }
    
    private func configureChatDrawerUserCell(at row: Int, with element: User) -> UICollectionViewCell {
        guard let cell = userListCollectionView.dequeueReusableCell(withReuseIdentifier: ChatDrawerUserCell.identifier,
                                                                    for: IndexPath(row: row, section: .zero)) as? ChatDrawerUserCell else {
            return UICollectionViewCell()
        }
        cell.configureUserCell(with: element)
        return cell
    }
    
    // view did load -> view 크기 계산 + Animation + 흐림 Effect
    // tap gesture, pan gesture
}