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
        case subscribeChatRoom
        case sendMessage(String)
        case chatDrawerButtonTapped
        case micButtonSizeChanged(MicButtonSize)
    }
    
    enum Mutation {
        case fetchUserList([Int: String])
        case appendNewMessage([Message])
        case setSendResult(Bool)
        case toggleDrawerState
        case setMicButtonSize(MicButtonSize)
        case connectSocket
        case reconnectSocket
    }
    
    struct State {
        var messageBox: MessageBox
        var sendResult: Bool = true
        var roomCode: String
        var presentDrawer: Bool
        var isSubscribingMessage: Bool = false
        var micButtonSize: MicButtonSize
    }
    
    private let networkService: NetworkServiceProviding
    private var userData: UserDataProviding
    private let roomID: Int
    private let messageParser: MessageParseProviding
    private var userListCache: [Int: String] = [:]
    
    let initialState: State
    
    init(networkService: NetworkServiceProviding,
         userData: UserDataProviding,
         messageParser: MessageParseProviding,
         roomID: Int,
         code: String) {
        
        self.networkService = networkService
        self.userData = userData
        self.messageParser = messageParser
        self.roomID = roomID
        initialState = State(messageBox: MessageBox(userID: userData.id),
                             roomCode: code,
                             presentDrawer: false,
                             micButtonSize: userData.micButtonSize)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .subscribeChatRoom:
            return currentState.isSubscribingMessage ?
                .just(.reconnectSocket) : .merge([ fetchUserList(),
                                                    .just(.connectSocket),
                                                    subscribeMessages(),
                                                    subscribeNewUser(),
                                                    subscribeLeavedUser()
                                                    ])
        case .sendMessage(let message):
            return requestSendMessage(message: message)
        case .chatDrawerButtonTapped:
            return .just(.toggleDrawerState)
        case .micButtonSizeChanged(let size):
            userData.micButtonSize = size
            return .just((.setMicButtonSize(size)))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .fetchUserList(let cache):
            userListCache = cache
        case .appendNewMessage(let messages):
            state.messageBox.append(messages)
        case .setSendResult(let isSuccess):
            state.sendResult = isSuccess
        case .toggleDrawerState:
            state.presentDrawer.toggle()
        case .connectSocket:
            state.isSubscribingMessage = true
        case .reconnectSocket:
            networkService.reconnect()
        case .setMicButtonSize(let size):
            state.micButtonSize = size
        }
        return state
    }
        
    private func subscribeMessages() -> Observable<Mutation> {
        return networkService.getMessage(roomId: roomID, language: userData.language)
            .compactMap { $0.newMessage }
            .compactMap { [weak self] in
                self?.messageParser.parse(newMessage: $0)
            }
            .map { Mutation.appendNewMessage($0) }
    }
    
    private func subscribeNewUser() -> Observable<Mutation> {
        return networkService.subscribeNewUser(roomID: roomID)
            .compactMap { $0.newUser }
            .compactMap { [weak self] in
                guard let self = self else {
                    return []
                }
                self.userListCache.updateValue($0.nickname, forKey: $0.id)
                return [Message(systemText: "\($0.nickname)\(Strings.Chat.userJoinMessage)")]
            }
            .map { Mutation.appendNewMessage($0) }
    }
    
    private func subscribeLeavedUser() -> Observable<Mutation> {
        return networkService.subscribeLeavedUser(roomID: roomID)
            .compactMap { $0.deleteUser?.id }
            .compactMap { [weak self] in
                guard let self = self else {
                    return []
                }
                let nickName = self.userListCache[$0]
                self.userListCache.removeValue(forKey: $0)
                return [Message(systemText: "\(nickName ?? Strings.Chat.unknownUserNickname)\(Strings.Chat.userLeaveMessage)")]
            }
            .map { Mutation.appendNewMessage($0) }
    }
    
    private func requestSendMessage(message: String) -> Observable<Mutation> {
        return networkService.sendMessage(text: message)
            .asObservable()
            .map { Mutation.setSendResult($0.createMessage) }
    }
    
    private func fetchUserList() -> Observable<Mutation> {
        return networkService.getUserList(of: roomID)
            .asObservable()
            .compactMap { $0.roomById?.users }
            .map {
                $0.reduce([Int: String]()) { cache, user in
                    var cache = cache
                    cache.updateValue(user.nickname, forKey: user.id)
                    return cache
                }
            }
            .map { Mutation.fetchUserList($0) }
    }
}
