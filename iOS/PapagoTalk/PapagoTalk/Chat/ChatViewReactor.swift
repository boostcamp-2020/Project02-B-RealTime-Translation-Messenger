//
//  ChatViewReactor.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/25.
//

import Foundation
import ReactorKit

final class ChatViewReactor: Reactor {
    
    // TODO: 모델 분리 예정
    var networkService = NetworkService()
    
    enum Action {
        case subscribeNewMessages(Int)
        case sendMessage(String)
    }
    
    enum Mutation {
        case appendNewMessage(Message)
        case setSendResult(Bool)
    }
    
    struct State {
        var messageBox: MessageBox
        var sendResult: Bool = true
    }
    
    let initialState: State
    let user = ChatViewController.user
    
    init() {
        initialState = State(messageBox: MessageBox())
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .subscribeNewMessages(let roomID):
            return networkService.getMessage(roomId: roomID)
                .compactMap { $0.newMessage }
                // TODO: 막 넣은 데이터들 API 생기면 수정
                // TODO: 구조 개선
                .map { Mutation.appendNewMessage(Message(id: $0.id,
                                                         of: $0.text,
                                                         by: User(id: $0.user.id,
                                                                  nickName: $0.user.nickname,
                                                                  image: $0.user.avatar,
                                                                  language: .korean),
                                                         language: $0.source,
                                                         timeStamp: "1606743370")) }
        case .sendMessage(let message):
            return networkService.sendMessage(text: message,
                                              source: user.language.code,
                                              userId: user.id,
                                              roomId: 1)
                .asObservable()
                .map { Mutation.setSendResult($0.createMessage) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .appendNewMessage(let message):
            state.messageBox.messages.append(message)
        case .setSendResult(let isSuccess):
            state.sendResult = isSuccess
        }
        return state
    }
}
