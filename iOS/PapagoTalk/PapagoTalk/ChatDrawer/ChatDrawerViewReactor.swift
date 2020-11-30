//
//  ChatDrawerViewReactor.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/11/30.
//

import Foundation
import ReactorKit

final class ChatDrawerViewReactor: Reactor {
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    let initialState: State
    
    init() {
        initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        
        }
        return state
    }
}
