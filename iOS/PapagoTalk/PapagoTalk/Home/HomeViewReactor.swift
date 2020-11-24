//
//  HomeViewReactor.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/24.
//

import Foundation
import ReactorKit

final class HomeViewReactor: Reactor {
    
    enum Action {
        case nickNameChanged(String)
    }
    
    enum Mutation {
        case setNickName(String)
        case shakeNickNameTextField(Bool)
    }
    
    struct State {
        var nickName: String
        var isInvalidNickNameLength: Bool
    }
    
    var initialState: State
    
    init() {
        self.initialState = State(nickName: "", isInvalidNickNameLength: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .nickNameChanged(let nickName):
            return blockNickNameMaxLength(input: nickName)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setNickName(let nickName):
            state.nickName = nickName
        case .shakeNickNameTextField(let needShake):
            state.isInvalidNickNameLength = needShake
        }
        return state
    }
    
    private func blockNickNameMaxLength(input nickName: String) -> Observable<Mutation> {
        let needShake = nickName.count > 12
        return Observable.concat([
            Observable.just(Mutation.shakeNickNameTextField(needShake)),
            Observable.just(Mutation.setNickName(String(nickName.prefix(12))))
        ])
    }
}
