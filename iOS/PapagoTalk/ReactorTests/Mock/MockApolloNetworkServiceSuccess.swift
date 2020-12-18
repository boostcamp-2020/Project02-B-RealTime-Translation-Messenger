//
//  MockApolloNetworkServiceSuccess.swift
//  PapagoTalkHomeTests
//
//  Created by 송민관 on 2020/12/08.
//

import XCTest
import Foundation
import RxSwift
@testable import PapagoTalk

struct MockApolloNetworkServiceSuccess: NetworkServiceProviding {
    func sendMessage(text: String) -> Maybe<SendMessageMutation.Data> {
        return Maybe.just(.init(createMessage: true))
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
                                                          lang: "ja",
                                                          isDeleted: false)])))
    }
    
    func translate(text: String) -> Maybe<String> {
        return .just("TranslatedText")
    }

    func sendSystemMessage(type: String) {
        guard type == "in" || type == "out" else {
            XCTFail("System Message Type Should be \"in\" or \"out\"")
            return
        }
        XCTAssert(true)
    }
    
    func leaveRoom() {
        XCTAssert(true)
    }
}
