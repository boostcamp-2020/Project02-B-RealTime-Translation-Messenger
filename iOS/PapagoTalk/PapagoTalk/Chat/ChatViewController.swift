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
    @IBOutlet weak var sendButton: UIButton!
    
    var disposeBag = DisposeBag()
    var messages = [Message]()
    var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = ChatViewReactor()
        bind()
    }
    
    func bind(reactor: ChatViewReactor) {
    }
    
    private func bind() {
        inputBarTextView.rx.text
            .orEmpty
            .compactMap { [weak self] text in
                self?.calculateTextViewHeight(with: text)
            }
            .asObservable()
            .distinctUntilChanged()
            .bind(to: inputBarTextViewHeight.rx.constant)
            .disposed(by: disposeBag)
        
        chatCollectionView.delegate = self
        chatCollectionView.dataSource = self
        
        sendButton.rx.tap
            .withLatestFrom(inputBarTextView.rx.text)
            .map { text -> Message in
                guard let text = text else {
                    return Message(text: "")
                }
                return Message(text: text) }
            .subscribe(onNext: { message in
                print("sent")
                self.networkService.sendMessage(text: message.text, source: "ko", nickname: "yejin", roomId: 1)
                    .subscribe()
                    .disposed(by: self.disposeBag)
                self.inputBarTextView.text = nil
            })
            .disposed(by: disposeBag)
        
        networkService.getMessage(roomId: 1)
            .map { Message(text: $0.newMessage!.text) }
            .asObservable()
            .subscribe(onNext: {
                self.messages.append($0)
                self.chatCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
            
    }
    
    private func calculateTextViewHeight(with text: String) -> CGFloat {
        let size = inputBarTextView.sizeThatFits(CGSize(width: inputBarTextView.bounds.size.width,
                                                        height: CGFloat.greatestFiniteMagnitude))
        return min(Constant.inputBarTextViewMaxHeight, size.height)
    }
}

struct Message {
    let text: String
}

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
