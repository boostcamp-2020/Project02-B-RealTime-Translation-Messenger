//
//  ChatViewReactor.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/25.
//

import Foundation
import ReactorKit

final class ChatViewReactor: Reactor {
    
    enum Action {
        case sendMessage(String)
    }
    
    enum Mutation {
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
        case .sendMessage(let message):
            // Message 조립
            // API 요청 + SideEffect (completion)
            // return map -> 결과
            return Observable.just(Mutation.setSendResult(true))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setSendResult(let isSuccess):
            state.sendResult = isSuccess
        }
        return state
    }
}
