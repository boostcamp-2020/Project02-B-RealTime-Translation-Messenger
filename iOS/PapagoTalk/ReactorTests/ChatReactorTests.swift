//
//  ChatReactorTests.swift
//  PapagoTalkTests
//
//  Created by 송민관 on 2020/11/19.
//

import XCTest
@testable import PapagoTalk

class ChatReactorTests: XCTestCase {
    
    func test_subscribeMessages_success() throws {
        // Given
        let reactor = ChatViewReactor(networkService: MockNetworkServiceSuccess(),
                                      userData: MockUserDataProvider(),
                                      messageParser: MockMessageParser(),
                                      chatWebSocket: MockWebSocketService(),
                                      historyManager: MockHistoryManager(),
                                      roomID: 8,
                                      code: "")
        
        // When
        reactor.action.onNext(.subscribeChatRoom)
        
        // Then
        XCTAssertEqual(reactor.currentState.isSubscribingMessage, true)
    }
    
    func test_subscribeMessages_reconnect() throws {
        // Given
        let reactor = ChatViewReactor(networkService: MockNetworkServiceSuccess(),
                                      userData: MockUserDataProvider(),
                                      messageParser: MockMessageParser(),
                                      chatWebSocket: MockWebSocketService(),
                                      historyManager: MockHistoryManager(),
                                      roomID: 8,
                                      code: "")
        
        // When
        reactor.action.onNext(.subscribeChatRoom)
        reactor.action.onNext(.subscribeChatRoom)
        
        // Then
        XCTAssertEqual(reactor.currentState.isSubscribingMessage, true)

    }
    
    func test_sendMessage_success() throws {
        // Given
        let reactor = ChatViewReactor(networkService: MockNetworkServiceSuccess(),
                                      userData: MockUserDataProvider(),
                                      messageParser: MockMessageParser(),
                                      chatWebSocket: MockWebSocketService(),
                                      historyManager: MockHistoryManager(),
                                      roomID: 8,
                                      code: "")

        // When
        reactor.action.onNext(.sendMessage("sendMessageTest"))

        // Then
        XCTAssertEqual(reactor.currentState.sendResult, true)
    }
    
    func test_sendMessage_fail() throws {
        // Given
        let reactor = ChatViewReactor(networkService: MockNetworkServiceFailure(),
                                      userData: MockUserDataProvider(),
                                      messageParser: MockMessageParser(),
                                      chatWebSocket: MockWebSocketService(),
                                      historyManager: MockHistoryManager(),
                                      roomID: 8,
                                      code: "")

        // When
        reactor.action.onNext(.sendMessage("sendMessageTest"))

        // Then
        XCTAssertEqual(reactor.currentState.sendResult, false)
    }
    
    func test_presentChatDrawer() throws {
        // Given
        let reactor = ChatViewReactor(networkService: MockNetworkServiceSuccess(),
                                      userData: MockUserDataProvider(),
                                      messageParser: MockMessageParser(),
                                      chatWebSocket: MockWebSocketService(),
                                      historyManager: MockHistoryManager(),
                                      roomID: 8,
                                      code: "")

        // When
        reactor.action.onNext(.chatDrawerButtonTapped)

        // Then
        XCTAssertEqual(reactor.currentState.presentDrawer, true)
    }
    
    func test_dismissChatDrawer() throws {
        // Given
        let reactor = ChatViewReactor(networkService: MockNetworkServiceSuccess(),
                                      userData: MockUserDataProvider(),
                                      messageParser: MockMessageParser(),
                                      chatWebSocket: MockWebSocketService(),
                                      historyManager: MockHistoryManager(),
                                      roomID: 8,
                                      code: "")
        reactor.action.onNext(.chatDrawerButtonTapped)

        // When
        reactor.action.onNext(.chatDrawerButtonTapped)

        // Then
        XCTAssertEqual(reactor.currentState.presentDrawer, false)
    }
}
