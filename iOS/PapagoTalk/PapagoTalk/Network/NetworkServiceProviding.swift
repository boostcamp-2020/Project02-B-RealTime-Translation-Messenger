//
//  NetworkServiceProviding.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/02.
//

import Foundation
import RxSwift

protocol NetworkServiceProviding {
    func sendMessage(text: String) -> Maybe<SendMessageMutation.Data>
    
    func getMessage(roomID: Int,
                    userID: Int) -> Observable<GetMessageSubscription.Data>
    
    func enterRoom(user: User,
                   code: String) -> Maybe<JoinChatResponse>
    
    func createRoom(user: User) -> Maybe<CreateRoomResponse>
    
    func getUserList(of roomID: Int) -> Maybe<FindRoomByIdQuery.Data>
    
    func translate(text: String) -> Maybe<String>
    
    func leaveRoom()
    
    func reconnect()
}
