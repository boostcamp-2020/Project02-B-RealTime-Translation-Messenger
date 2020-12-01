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
        case fetchUsers
        case chatRoomCodeButtonTapped
        case leaveChatRoomButtonTapped
    }
    
    enum Mutation {
        case setUsers([User]) // RoomNumber?
        case alertRoomCode(String)
        case setLeaveChatRoom(Bool)
    }
    
    struct State {
        var users: [User]
        var roomCode: String
        var leaveChatRoom: Bool
    }
    
    let initialState: State
    
    init() {
        initialState = State(users: [User](), roomCode: "", leaveChatRoom: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchUsers:
            return .just(Mutation.setUsers([User]()))
        case .chatRoomCodeButtonTapped:
            return .just(Mutation.alertRoomCode(""))
        case .leaveChatRoomButtonTapped:
            return .just(Mutation.setLeaveChatRoom(true))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setUsers(let users):
            state.users = users
        case .alertRoomCode(let roomCode):
            state.roomCode = roomCode
        case .setLeaveChatRoom(let leaveChatRoom):
            state.leaveChatRoom = leaveChatRoom
        }
        return state
    }
}
