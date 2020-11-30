//
//  ChatCodeInputViewController.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/28.
//

import UIKit
import ReactorKit
import RxCocoa

final class ChatCodeInputViewController: UIViewController, StoryboardView {
    
    @IBOutlet var inputLabels: [UILabel]!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var disposeBag = DisposeBag()
    var alertFactory: AlertFactoryType = AlertFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = ChatCodeInputReactor()
        bind()
    }
    
    func bind(reactor: ChatCodeInputReactor) {
        numberButtons.forEach { button in
            button.rx.tap
                .compactMap { button.currentTitle }
                .map { Reactor.Action.numberButtonTapped($0) }
                .bind(to: reactor.action)
                .disposed(by: disposeBag)
        }
        
        removeButton.rx.tap
            .map { Reactor.Action.removeButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        inputLabels.enumerated().forEach { index, label in
            reactor.state.map { $0.codeInput[index] }
                .distinctUntilChanged()
                .bind(to: label.rx.text)
                .disposed(by: disposeBag)
        }
        
        reactor.state.compactMap { $0.joinChatResponse }
            .distinctUntilChanged()
            .do(onNext: { [weak self] in
                self?.moveToChat(userId: $0.userId, roomId: $0.roomId)
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.errorMessage }
            .distinctUntilChanged()
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] errorMessage in
                guard let message = errorMessage else {
                    return
                }
                self?.alert(message: message)
            })
            .disposed(by: disposeBag)
    }

    private func bind() {
        cancelButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in self?.navigationController?.popViewController(animated: true) })
            .disposed(by: disposeBag)
        
    }
    
    private func alert(message: String) {
        present(alertFactory.alert(message: message), animated: true)
    }
    
    private func moveToChat(userId: Int, roomId: Int) {
        guard let chatVC = storyboard?.instantiateViewController(identifier: ChatViewController.identifier) as? ChatViewController else {
            return
        }
        chatVC.userId = userId
        chatVC.roomID = roomId
        navigationController?.pushViewController(chatVC, animated: true)
    }
}
