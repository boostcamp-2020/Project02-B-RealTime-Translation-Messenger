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

    @IBOutlet private weak var inputBarTextView: UITextView!
    @IBOutlet private weak var inputBarTextViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var chatCollectionView: UICollectionView!
    @IBOutlet private weak var sendButton: UIButton!
    
    var disposeBag = DisposeBag()
    
    // TODO: 모델 분리 예정
    var messages = [Message]()
    // TODO: 분리 예정
    var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = ChatViewReactor()
        bind()
    }
    
    func bind(reactor: ChatViewReactor) {
        sendButton.rx.tap
            .withLatestFrom(inputBarTextView.rx.text)
            .compactMap { $0 }
            .filter { !$0.isEmpty }
            .map { Reactor.Action.sendMessage($0) }
            .do(afterNext: { [weak self] _ in
                self?.inputBarTextView.text = nil
            })
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        //
        //  reactor.state.map {  }
        //
        
        // TODO: 이동 예정
        networkService.getMessage(roomId: 1)
            .map { Message(text: $0.newMessage!.text) }
            .asObservable()
            .subscribe(onNext: {
                self.messages.append($0)
                self.chatCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        // TODO: 따로 함수로 정리
        inputBarTextView.rx.text
            .orEmpty
            .compactMap { [weak self] text in
                self?.calculateTextViewHeight(with: text)
            }
            .asObservable()
            .distinctUntilChanged()
            .bind(to: inputBarTextViewHeight.rx.constant)
            .disposed(by: disposeBag)
        
        // TODO: 삭제 예정
        chatCollectionView.delegate = self
        chatCollectionView.dataSource = self
        //            .subscribe(onNext: { message in
        //                print("sent")
        //                self.networkService.sendMessage(text: message.text, source: "ko", nickname: "yejin", roomId: 1)
        //                    .subscribe()
        //                    .disposed(by: self.disposeBag)
        //                self.inputBarTextView.text = nil
        //            })
        //            .disposed(by: disposeBag)
    }
    
    private func calculateTextViewHeight(with text: String) -> CGFloat {
        let size = inputBarTextView.sizeThatFits(CGSize(width: inputBarTextView.bounds.size.width,
                                                        height: CGFloat.greatestFiniteMagnitude))
        return min(Constant.inputBarTextViewMaxHeight, size.height)
    }
}

// TODO: Rx로 수정
extension ChatViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath) as? TestCell else {
            return UICollectionViewCell()
        }
        cell.text.text = messages[indexPath.row].text
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 40)
    }
}
