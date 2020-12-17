//
//  ChatDrawerReactorTests.swift
//  PapagoTalkTests
//
//  Created by Byoung-Hwi Yoon on 2020/12/08.
//

import XCTest
@testable import PapagoTalk

class ChatDrawerReactorTests: XCTestCase {

    func test_fetchUsers() throws {
        // Given
        let reactor = ChatDrawerViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                            userData: UserDataProviderMock(),
                                            roomID: 1,
                                            roomCode: "123456")

        // When
        reactor.action.onNext(.fetchUsers)

        // Then
        XCTAssertEqual(reactor.currentState.users.count, 3)
        XCTAssertEqual(reactor.currentState.users[0].id, 1)
        XCTAssertEqual(reactor.currentState.users[1].nickName, "test2")
        XCTAssertEqual(reactor.currentState.users[2].language, .japanese)
    }
    
    func test_same_roomCode_after_chatRoomCodeButton_tapped() throws {
        // Given
        let reactor = ChatDrawerViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                            userData: UserDataProviderMock(),
                                            roomID: 1,
                                            roomCode: "123456")
        
        // When
        reactor.action.onNext(.chatRoomCodeButtonTapped)

        // Then
        XCTAssertEqual(reactor.currentState.roomCode.data!, "123456")
    }
    
    func test_toast_after_chatRoomCodeButton_tapped() throws {
        // Given
        let reactor = ChatDrawerViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                            userData: UserDataProviderMock(),
                                            roomID: 1,
                                            roomCode: "123456")
        
        // When
        reactor.action.onNext(.chatRoomCodeButtonTapped)

        // Then
        XCTAssertEqual(reactor.currentState.toastMessage.data!, Strings.ChatDrawer.chatCodeDidCopyMessage)
    }
    
    func test_revision_increase_when_chatRoomCodeButton_tapped() throws {
        // Given
        let reactor = ChatDrawerViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                            userData: UserDataProviderMock(),
                                            roomID: 1,
                                            roomCode: "123456")
        
        let roomCodeRevisionBeforeTap = reactor.currentState.roomCode
        let toastRevisionBeforeTap = reactor.currentState.toastMessage

        // When
        reactor.action.onNext(.chatRoomCodeButtonTapped)

        // Then
        XCTAssertNotEqual(reactor.currentState.roomCode, roomCodeRevisionBeforeTap)
        XCTAssertNotEqual(reactor.currentState.toastMessage, toastRevisionBeforeTap)
    }
    
    func test_leaveChatRoomButton_tapped() throws {
        // Given
        let reactor = ChatDrawerViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                            userData: UserDataProviderMock(),
                                            roomID: 1,
                                            roomCode: "123456")
        
        // When
        reactor.action.onNext(.leaveChatRoomButtonTapped)

        // Then
        XCTAssertEqual(reactor.currentState.leaveChatRoom, true)
    }
}
