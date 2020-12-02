//
//  ChatDrawerViewController.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/30.
//

import UIKit
import ReactorKit
import RxCocoa
import Toaster

final class ChatDrawerViewController: UIViewController, StoryboardView {
    
    @IBOutlet private weak var userListCollectionView: UICollectionView!
    @IBOutlet private weak var chatRoomCodeButton: UIButton!
    @IBOutlet private weak var leaveChatRoomButton: UIButton!
    
    var disposeBag = DisposeBag()
    
    init?(coder: NSCoder, reactor: ChatDrawerViewReactor) {
        super.init(coder: coder)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
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
        
        reactor.state.compactMap { $0.roomCode }
            .distinctUntilChanged()
            .asObservable()
            .subscribe(onNext: {
                UIPasteboard.general.string = $0
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.needToast }
            .filter { $0 }
            .do { [weak self] _ in
                self?.configureToast()
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.leaveChatRoom }
            .filter { $0 }
            .do { [weak self] _ in
                // TODO: 알림 메시지?
                self?.dismiss(animated: true, completion: {
                    self?.navigationController?.popViewController(animated: true)
                })
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        userListCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func configureChatDrawerUserCell(at row: Int, with element: User) -> UICollectionViewCell {
        guard let cell = userListCollectionView.dequeueReusableCell(withReuseIdentifier: ChatDrawerUserCell.identifier,
                                                                    for: IndexPath(row: row, section: .zero)) as? ChatDrawerUserCell else {
            return UICollectionViewCell()
        }
        cell.configureUserCell(with: element)
        return cell
    }
    
    private func configureToast() {
        Toast(text: "채팅방 코드가 복사되었습니다.", delay: 0, duration: 2).show()
    }
}

extension ChatDrawerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 60)
    }
}
