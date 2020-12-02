//
//  SpeechViewReactor.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/02.
//

import Foundation
import ReactorKit

final class SpeechViewReactor: Reactor {
    
    enum Action {
        case microphoneButtonTapped
    }
    
    enum Mutation {
        case mic
    }
    
    struct State {
        
    }
    
    let initialState: State
    
    init() {
        initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .microphoneButtonTapped:
            return .just(Mutation.mic)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .mic:
            break
        }
        return state
    }
}
