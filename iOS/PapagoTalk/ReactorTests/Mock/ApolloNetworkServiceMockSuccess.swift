//
//  ApolloNetworkServiceMockSuccess.swift
//  PapagoTalkHomeTests
//
//  Created by 송민관 on 2020/12/08.
//

import Foundation
import RxSwift

struct ApolloNetworkServiceMockSuccess: NetworkServiceProviding {
    func sendMessage(text: String) -> Maybe<SendMessageMutation.Data> {
        return Maybe.just(.init(createMessage: true))
    }
    
    func getMessage(roomId: Int,
                    language: Language) -> Observable<GetMessageSubscription.Data> {
        return Observable.just(.init(newMessage: .init(id: 1,
                                                       text: "안녕하세요",
                                                       source: "ko",
                                                       createdAt: "1607480160000",
                                                       user: .init(id: 2,
                                                                   nickname: "testUser",
                                                                   avatar: "",
                                                                   lang: "ko"))))
    }
    
    func enterRoom(user: User,
                   code: String) -> Maybe<JoinChatResponse> {
        return Maybe.just(JoinChatResponse.init(userId: 1, roomId: 8, token: "testToken"))
    }
    
    func createRoom(user: User) -> Maybe<CreateRoomResponse> {
        return Maybe.just(CreateRoomResponse.init(userId: 1, roomId: 8, code: "545305", token: "testToken"))
    }
    
    func getUserList(of roomID: Int) -> Maybe<FindRoomByIdQuery.Data> {
        return Maybe.just(.init(roomById: .init(code: "545305",
                                                users: [
                                                    .init(id: 1,
                                                          nickname: "test1",
                                                          avatar: "",
                                                          lang: "en"),
                                                    .init(id: 2,
                                                          nickname: "test2",
                                                          avatar: "",
                                                          lang: "ko"),
                                                    .init(id: 3,
                                                          nickname: "test3",
                                                          avatar: "",
                                                          lang: "fr")])))
    }
    
    func subscribeLeavedUser(roomID: Int) -> Observable<LeavedUserSubscription.Data> {
        return Observable.just(.init(deleteUser: .init(id: 0)))
    }
    
    func subscribeNewUser(roomID: Int) -> Observable<NewUserSubscription.Data> {
        return Observable.just(.init(newUser: .init(id: 0, nickname: "", avatar: "", lang: "")))
    }
    
    func leaveRoom() {
        
    }
    
    func reconnect() {
        
    }
}
