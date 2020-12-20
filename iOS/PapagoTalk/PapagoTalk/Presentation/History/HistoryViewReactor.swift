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
        case fetchHistory
        case reEnterButtonTapped(String)
    }
    
    enum Mutation {
        case fetchHistory([ChatRoomHistory])
        case joinChatRoom(ChatRoomInfo)
        case alertError(JoinChatError)
    }
    
    struct State {
        var historyList: [ChatRoomHistory]
        var errorMessage: RevisionedData<String>
        var chatRoomInfo: ChatRoomInfo?
    }
    
    private let historyManager: HistoryServiceProviding
    private let networkService: NetworkServiceProviding
    private var userData: UserDataProviding
    
    let initialState: State
    
    init(networkService: NetworkServiceProviding,
         userData: UserDataProviding,
         historyManager: HistoryServiceProviding) {
        
        self.networkService = networkService
        self.userData = userData
        self.historyManager = historyManager
        initialState = State(historyList: [], errorMessage: RevisionedData(data: ""))
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchHistory:
            return Observable.just(historyManager.fetch().reversed())
                .map { Mutation.fetchHistory($0) }
        case .reEnterButtonTapped(let code):
            return requestEnterRoom(code: code)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .fetchHistory(let historyList):
            state.historyList = historyList
        case .joinChatRoom(let roomInfo):
            state.chatRoomInfo = roomInfo
            userData.id = roomInfo.userID
            userData.token = roomInfo.token
        case .alertError(let error):
            state.errorMessage = state.errorMessage.update(error.message)
        }
        return state
    }
    
    private func requestEnterRoom(code: String) -> Observable<Mutation> {
        networkService.leaveRoom()
        return networkService.enterRoom(user: userData.user, code: code)
            .asObservable()
            .map { Mutation.joinChatRoom(ChatRoomInfo(response: $0, code: code)) }
            .catchError { [weak self] in
                guard let self = self else { return .just(.alertError(.networkError)) }
                return self.handleError($0)
            }
    }
    
    private func handleError(_ error: Error) -> Observable<Mutation> {
        guard let error = error as? JoinChatError else {
            return .just(.alertError(.networkError))
        }
        return .just(.alertError(error))
    }
}
