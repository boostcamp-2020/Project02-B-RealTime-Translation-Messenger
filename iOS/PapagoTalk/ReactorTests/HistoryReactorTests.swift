//
//  HistoryReactorTests.swift
//  ReactorTests
//
//  Created by 송민관 on 2020/12/17.
//

import XCTest
import Foundation
@testable import PapagoTalk

class HistoryReactorTests: XCTestCase {
    
    func test_should_fetch_after_view_will_appear() {
        // Given
        let reactor = HistoryViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                      userData: MockUserDataProvider(),
                                      historyManager: MockHistoryManager())

        // When
        reactor.action.onNext(.viewWillAppear)

        // Then
        XCTAssertFalse(reactor.currentState.historyList.isEmpty)
    }
    
    func test_re_enter_success() {
        // Given
        let reactor = HistoryViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                      userData: MockUserDataProvider(),
                                      historyManager: MockHistoryManager())

        // When
        reactor.action.onNext(.reEnterButtonTapped("code"))

        // Then
        XCTAssertEqual(reactor.currentState.chatRoomInfo?.code, "code")
        XCTAssertEqual(reactor.currentState.chatRoomInfo?.roomID, 8)
        XCTAssertEqual(reactor.currentState.chatRoomInfo?.userID, 1)
        XCTAssertEqual(reactor.currentState.chatRoomInfo?.token, "testToken")
    }
    
    func test_re_enter_fail() {
        // Given
        let reactor = HistoryViewReactor(networkService: MockApolloNetworkServiceFailure(),
                                      userData: MockUserDataProvider(),
                                      historyManager: MockHistoryManager())

        // When
        reactor.action.onNext(.reEnterButtonTapped("code"))

        // Then
        XCTAssertEqual(reactor.currentState.errorMessage.data, JoinChatError.networkError.message)
    }
    
    func test_re_enter_fail_with_non_exist_room() {
        // Given
        let reactor = HistoryViewReactor(networkService: MockApolloNetworkServiceFailure(),
                                      userData: MockUserDataProvider(),
                                      historyManager: MockHistoryManager())

        // When
        reactor.action.onNext(.reEnterButtonTapped("999999"))

        // Then
        XCTAssertEqual(reactor.currentState.errorMessage.data, JoinChatError.cannotFindRoom.message)
    }
    
}
