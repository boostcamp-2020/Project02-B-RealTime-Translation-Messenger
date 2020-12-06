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
        case subscribeNewMessages
        case sendMessage(String)
        case chatDrawerButtonTapped
    }
    
    enum Mutation {
        case appendNewMessage([Message])
        case setSendResult(Bool)
        case toggleDrawerState
    }
    
    struct State {
        var messageBox: MessageBox
        var sendResult: Bool = true
        var roomCode: String
        var presentDrawer: Bool
    }
    
    private let networkService: NetworkServiceProviding
    private let userData: UserDataProviding
    private let roomID: Int
    private var socketObservable: Observable<Mutation>?
    private let messageParser: MessageParser
    
    let initialState: State
    
    init(networkService: NetworkServiceProviding,
         userData: UserDataProviding,
         messageParser: MessageParser,
         roomID: Int,
         code: String) {
        
        self.networkService = networkService
        self.userData = userData
        self.messageParser = messageParser
        self.roomID = roomID
        initialState = State(messageBox: MessageBox(userID: userData.id),
                             roomCode: code,
                             presentDrawer: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .subscribeNewMessages:
            return subscribeMessages()
        case .sendMessage(let message):
            return requestSendMessage(message: message)
        case .chatDrawerButtonTapped:
            return .just(.toggleDrawerState)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .appendNewMessage(let messages):
            state.messageBox.append(messages)
        case .setSendResult(let isSuccess):
            state.sendResult = isSuccess
        case .toggleDrawerState:
            state.presentDrawer.toggle()
        }
        return state
    }
        
    private func subscribeMessages() -> Observable<Mutation> {
        return networkService.getMessage(roomId: roomID, language: userData.language)
            .compactMap { $0.newMessage }
            .compactMap { [weak self] in self?.messageParser.parse(newMessage: $0) }
            .map { Mutation.appendNewMessage($0) }
    }
    
    private func requestSendMessage(message: String) -> Observable<Mutation> {
        return networkService.sendMessage(text: message,
                                          source: userData.language.code,
                                          userId: userData.id,
                                          roomId: roomID)
            .asObservable()
            .map { Mutation.setSendResult($0.createMessage) }
    }
}
