//
//  MockApolloNetworkServiceSuccess.swift
//  PapagoTalkHomeTests
//
//  Created by 송민관 on 2020/12/08.
//

import Foundation
import RxSwift

struct MockApolloNetworkServiceSuccess: NetworkServiceProviding {
    func sendMessage(text: String) -> Maybe<SendMessageMutation.Data> {
        return Maybe.just(.init(createMessage: true))
    }
    
    func getMessage() -> Observable<GetMessageSubscription.Data> {
        return Observable.just(.init(newMessage: .init(id: 1,
                                                       text: "안녕하세요",
                                                       source: "ko",
                                                       createdAt: "1607480160000",
                                                       user: .init(id: 2,
                                                                   nickname: "testUser",
                                                                   avatar: "",
                                                                   lang: "ko"))))
    }
    
    func getMissingMessage(timeStamp: String) -> Maybe<GetMessageByTimeQuery.Data> {
        return .just(.init(allMessagesByTime: .init(repeating: .init(.init(id: 0,
                                                                           text: "",
                                                                           source: "",
                                                                           createdAt: "",
                                                                           user: .init(id: 0,
                                                                                       nickname: "",
                                                                                       avatar: "",
                                                                                       lang: ""))), count: 3)))
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
                                                          lang: "en",
                                                          isDeleted: false),
                                                    .init(id: 2,
                                                          nickname: "test2",
                                                          avatar: "",
                                                          lang: "ko",
                                                          isDeleted: false),
                                                    .init(id: 3,
                                                          nickname: "test3",
                                                          avatar: "",
                                                          lang: "fr",
                                                          isDeleted: false)])))
    }
    
    func translate(text: String) -> Maybe<String> {
        return .just("")
    }

    func sendSystemMessage(type: String) {
        
    }
    
    func leaveRoom() {
        
    }
    
    func reconnect() {
        
    }
}
