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
    }
    
    enum Mutation {
        case appendNewMessage(Message)
        case setSendResult(Bool)
    }
    
    struct State {
        var messageBox: MessageBox
        var sendResult: Bool = true
    }
    
    private let networkService: NetworkServiceProviding
    private let userData: UserDataProviding
    private let roomID: Int
    let initialState: State
    
    init(networkService: NetworkServiceProviding, userData: UserDataProviding, roomID: Int) {
        self.networkService = networkService
        self.userData = userData
        self.roomID = roomID
        initialState = State(messageBox: MessageBox())
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .subscribeNewMessages:
            return networkService.getMessage(roomId: roomID, language: userData.language)
                .compactMap { $0.newMessage }
                // TODO: 막 넣은 데이터들 API 생기면 수정
                // TODO: 구조 개선
                .map {
                    Mutation.appendNewMessage(Message(id: $0.id,
                                                      of: $0.text,
                                                      by: User(id: $0.user.id,
                                                               nickName: $0.user.nickname,
                                                               image: $0.user.avatar,
                                                               language: .korean), // 수정필요
                                                      language: $0.source,
                                                      timeStamp: $0.createdAt ?? "" )) }
        case .sendMessage(let message):
            return networkService.sendMessage(text: message,
                                              source: userData.language.code,
                                              userId: userData.id,
                                              roomId: roomID)
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
