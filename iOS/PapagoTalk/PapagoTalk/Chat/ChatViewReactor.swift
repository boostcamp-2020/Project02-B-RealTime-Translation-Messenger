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
    
    init() {
        initialState = State(messageBox: MessageBox())
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .subscribeNewMessages(let roomID):
            return networkService.getMessage(roomId: roomID)
                .compactMap { $0.newMessage }
                .map { Mutation.appendNewMessage(Message(userId: $0.user.id, text: $0.text)) }
        case .sendMessage(let message):
            return networkService.sendMessage(text: message, source: "ko", userId: 7, roomId: 1)
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
