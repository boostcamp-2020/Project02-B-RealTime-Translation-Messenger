//
//  HomeReactor.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/24.
//

import Foundation
import ReactorKit

final class HomeReactor: Reactor {
    
    enum Action {
        case nickNameChanged(String)
    }
    
    enum Mutation {
        case changeNickName(String)
    }
    
    struct State {
        var nickName: String
    }
    
    var initialState: State
    
    init() {
        self.initialState = State( nickName: "")
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .nickNameChanged(let nickName):
            return blockNickNameMaxLength(string: nickName)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .changeNickName(let nickName):
            var nickName = nickName
            if nickName.count > 12 { nickName = String(nickName.prefix(12)) }
            state.nickName = nickName
        }
        
        return state
    }
    
    private func blockNickNameMaxLength(string: String) -> Observable<Mutation> {
        return Observable.just(Mutation.changeNickName(String(string.prefix(12))))
    }
}
