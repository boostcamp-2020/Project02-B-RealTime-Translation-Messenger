//
//  JoinChatReactor.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/28.
//

import Foundation
import ReactorKit

final class ChatCodeInputReactor: Reactor {
    enum Action {
        case numberButtonTapped(String)
        case removeButtonTapped
    }
    
    enum Mutation {
        case setCodeInput(String)
        case removeCodeInput
        case joinChatRoom(JoinChatResponse)
        case alertError(JoinChatError)
        case clearState
    }
    
    struct State {
        var codeInput: [String]
        var cusor: Int
        var roomId: Int?
        var errorMessage: String?
        var user: User
        var joinChatResponse: JoinChatResponse?
    }
    
    private let maxCodeLength = 6
    private let networkService: NetworkServiceProviding
    private let user: User
    let initialState: State
    
    init(networkService: NetworkServiceProviding,
         userData: User) {
        
        self.networkService = networkService
        user = userData
        initialState = State(codeInput: [String](repeating: "", count: maxCodeLength),
                             cusor: 0,
                             user: user)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .numberButtonTapped(let tappedNumber):
            if currentState.cusor == maxCodeLength - 1 {
                return .concat([
                    .just(Mutation.setCodeInput(tappedNumber)),
                    requestEnterRoom(state: currentState, lastInput: tappedNumber)
                ])
            }
            return .just(Mutation.setCodeInput(tappedNumber))
        case .removeButtonTapped:
            return .just(Mutation.removeCodeInput)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setCodeInput(let tappedNumber):
            guard (0..<maxCodeLength) ~= state.cusor else {
                return state
            }
            state.codeInput[state.cusor] = tappedNumber
            state.cusor += 1
        case .removeCodeInput:
            state.cusor = (state.cusor <= 0) ? 0 : state.cusor - 1
            state.codeInput[state.cusor] = ""
        case .joinChatRoom(let response):
            state.user.id = response.userId
            state.roomId = response.roomId
            state.joinChatResponse = response
        case .alertError(let error):
            state.errorMessage = error.message
        case .clearState:
            state = initialState
        }
        return state
    }
    
    private func requestEnterRoom(state: State, lastInput: String) -> Observable<Mutation> {
        let code = state.codeInput.reduce("") { $0 + $1 } + lastInput
        return networkService.enterRoom(user: state.user, code: code)
            .asObservable()
            .map { Mutation.joinChatRoom($0) }
            .catchError { [weak self] in
                guard let self = self else {
                    return .just(Mutation.alertError(.networkError))
                }
                return self.handleError($0)
            }
    }
    
    private func handleError(_ error: Error) -> Observable<Mutation> {
        guard let error = error as? JoinChatError else {
            return .concat([
                .just(.alertError(.networkError)),
                .just(.clearState)
            ])
        }
        return .concat([
            .just(.alertError(error)),
            .just(.clearState)
        ])
    }
}
