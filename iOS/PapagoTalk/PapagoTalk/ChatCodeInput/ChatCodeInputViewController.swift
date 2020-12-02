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
    
    weak var coordinator: MainCoordinator?
    var alertFactory: AlertFactoryProviding
    var disposeBag = DisposeBag()
    
    init?(coder: NSCoder, reactor: ChatCodeInputReactor, alertFactory: AlertFactoryProviding) {
        self.alertFactory = alertFactory
        super.init(coder: coder)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        //FatalError?
        alertFactory = AlertFactory()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            .do(onNext: { [weak self] response in
                self?.coordinator?.codeInputToChat(roomID: response.roomId)
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
            .drive(onNext: { [weak self] _ in self?.dismiss(animated: true) })
            .disposed(by: disposeBag)
        
    }
    
    private func alert(message: String) {
        present(alertFactory.alert(message: message), animated: true)
    }
}
