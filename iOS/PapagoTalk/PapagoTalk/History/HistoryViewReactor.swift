//
//  HistoryViewReactor.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/13.
//

import Foundation
import ReactorKit

final class HistoryViewReactor: Reactor {
    
    enum Action {
        case viewWillAppear
    }
    
    enum Mutation {
        case fetchHistory([ChatRoomHistory])
    }
    
    struct State {
        var historyList: [ChatRoomHistory]
    }
    
    private let historyManager: HistoryManager
    
    let initialState: State
    
    init(historyManager: HistoryManager) {
        self.historyManager = historyManager
        initialState = State(historyList: [])
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return Observable.just(historyManager.fetch())
                .map { Mutation.fetchHistory($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .fetchHistory(let historyList):
            state.historyList = historyList
        }
        
        return state
    }
}
