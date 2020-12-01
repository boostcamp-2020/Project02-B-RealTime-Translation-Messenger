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
        var drawerState: Bool
    }
    
    private let networkService: NetworkServiceProviding
    private let userData: UserDataProviding
    private let roomID: Int
    let initialState: State
    
    init(networkService: NetworkServiceProviding, userData: UserDataProviding, roomID: Int, code: String) {
        self.networkService = networkService
        self.userData = userData
        self.roomID = roomID
        initialState = State(messageBox: MessageBox(userID: userData.id),
                             roomCode: code,
                             drawerState: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .subscribeNewMessages:
            return networkService.getMessage(roomId: roomID, language: userData.language)
                .compactMap { $0.newMessage }
                .compactMap { [weak self] in self?.seperateMessage(newMessage: $0) }
                .map { Mutation.appendNewMessage($0) }

        case .sendMessage(let message):
            return networkService.sendMessage(text: message,
                                              source: userData.language.code,
                                              userId: userData.id,
                                              roomId: roomID)
                .asObservable()
                .map { Mutation.setSendResult($0.createMessage) }
        case .chatDrawerButtonTapped:
            return Observable.just(Mutation.toggleDrawerState)
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
            state.drawerState.toggle()
        }
        return state
    }
    
    private func seperateMessage(newMessage: GetMessageSubscription.Data.NewMessage) -> [Message] {
        guard let timeStamp = newMessage.createdAt,
              let json = newMessage.text.data(using: .utf8),
              let translateResult: TranslateResult = try? json.decoded() else {
            return []
        }
        var messages = [Message]()
        let time = String(timeStamp.prefix(10))
        let sender = User(id: newMessage.user.id,
                          nickName: newMessage.user.nickname,
                          image: newMessage.user.avatar,
                          language: .english) // 수정 필요
        let originMessage = Message(id: newMessage.id,
                                    of: translateResult.originText,
                                    by: sender,
                                    language: newMessage.source,
                                    timeStamp: time)
        messages.append(originMessage)
        
        if newMessage.user.id != userData.id {
            let translatedMessage = Message(id: newMessage.id,
                                            of: translateResult.translatedText,
                                            by: sender,
                                            language: userData.language.code,
                                            timeStamp: time)
            messages.append(translatedMessage)
        }
        return messages
    }
}
