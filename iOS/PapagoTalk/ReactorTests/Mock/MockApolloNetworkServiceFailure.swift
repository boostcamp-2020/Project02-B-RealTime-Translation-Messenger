//
//  MockApolloNetworkServiceFailure.swift
//  PapagoTalkTests
//
//  Created by 송민관 on 2020/12/08.
//

import Foundation
import RxSwift
@testable import PapagoTalk

struct MockApolloNetworkServiceFailure: NetworkServiceProviding {

    func sendMessage(text: String) -> Maybe<SendMessageMutation.Data> {
        return Maybe.just(.init(createMessage: false))
    }
    
    func getMessage() -> Observable<GetMessageSubscription.Data> {
        return Observable.just(.init(newMessage: .init(id: 1,
                                                       text: "안녕하세요",
                                                       source: "ko",
                                                       createdAt: "2020",
                                                       user: .init(id: 1,
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
        return Maybe.error(JoinChatError.networkError)
    }
    
    func createRoom(user: User) -> Maybe<CreateRoomResponse> {
        return Maybe.error(JoinChatError.networkError)
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
                                                          isDeleted: false)
                                                ])))
    }
    
    func translate(text: String) -> Maybe<String> {
        return .just("")
    }
    
    func leaveRoom() {
        
    }

    func sendSystemMessage(type: String) {
        
    }

    func reconnect() {

    }
}
