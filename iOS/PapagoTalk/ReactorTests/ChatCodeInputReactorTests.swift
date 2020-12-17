//
//  ChatCodeInputReactorTests.swift
//  PapagoTalkTests
//
//  Created by 송민관 on 2020/12/08.
//

import XCTest
@testable import PapagoTalk

class ChatCodeInputReactorTests: XCTestCase {

    func test_codeNumberInput_firstNumber() throws {
        // Given
        let reactor = ChatCodeInputViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                               userData: MockUserDataProvider())
        
        // When
        reactor.action.onNext(.numberButtonTapped("5"))
        
        // Then
        let code = reactor.currentState.codeInput.reduce("") { $0 + $1 }
        XCTAssertEqual(code, "5")
        XCTAssertEqual(reactor.currentState.codeInput[0], "5")
        XCTAssertEqual(reactor.currentState.cusor, 1)
    }
    
    func test_codeNumberInput_thirdNumber() throws {
        // Given
        let reactor = ChatCodeInputViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                               userData: MockUserDataProvider())
        reactor.action.onNext(.numberButtonTapped("5"))
        reactor.action.onNext(.numberButtonTapped("4"))

        // When
        reactor.action.onNext(.numberButtonTapped("5"))

        // Then
        let code = reactor.currentState.codeInput.reduce("") { $0 + $1 }
        XCTAssertEqual(code, "545")
        XCTAssertEqual(reactor.currentState.codeInput[2], "5")
        XCTAssertEqual(reactor.currentState.cusor, 3)
    }
    
    func test_codeNumberInput_sixthNumber() throws {
        // Given
        let reactor = ChatCodeInputViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                               userData: MockUserDataProvider())
        reactor.action.onNext(.numberButtonTapped("8"))
        reactor.action.onNext(.numberButtonTapped("9"))
        reactor.action.onNext(.numberButtonTapped("0"))
        reactor.action.onNext(.numberButtonTapped("1"))
        reactor.action.onNext(.numberButtonTapped("2"))

        // When
        reactor.action.onNext(.numberButtonTapped("3"))

        // Then
        let code = reactor.currentState.codeInput.reduce("") { $0 + $1 }
        XCTAssertEqual(code, "890123")
        XCTAssertEqual(reactor.currentState.codeInput[5], "3")
        XCTAssertEqual(reactor.currentState.cusor, 6)
    }
    
    func test_codeNumberInput_above_maxLength() throws {
        // Given
        let reactor = ChatCodeInputViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                               userData: MockUserDataProvider())
        reactor.action.onNext(.numberButtonTapped("1"))
        reactor.action.onNext(.numberButtonTapped("2"))
        reactor.action.onNext(.numberButtonTapped("3"))
        reactor.action.onNext(.numberButtonTapped("4"))
        reactor.action.onNext(.numberButtonTapped("5"))
        reactor.action.onNext(.numberButtonTapped("6"))

        // When
        reactor.action.onNext(.numberButtonTapped("7"))

        // Then
        let code = reactor.currentState.codeInput.reduce("") { $0 + $1 }
        XCTAssertEqual(code, "123456")
        XCTAssertEqual(reactor.currentState.codeInput[5], "6")
        XCTAssertEqual(reactor.currentState.codeInput.count, 6)
        XCTAssertEqual(reactor.currentState.cusor, 6)
    }
    
    func test_codeNumberRemove_fifthNumber() throws {
        // Given
        let reactor = ChatCodeInputViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                               userData: MockUserDataProvider())
        reactor.action.onNext(.numberButtonTapped("2"))
        reactor.action.onNext(.numberButtonTapped("4"))
        reactor.action.onNext(.numberButtonTapped("3"))
        reactor.action.onNext(.numberButtonTapped("7"))
        reactor.action.onNext(.numberButtonTapped("9"))

        // When
        reactor.action.onNext(.removeButtonTapped)

        // Then
        let code = reactor.currentState.codeInput.reduce("") { $0 + $1 }
        XCTAssertEqual(code, "2437")
        XCTAssertEqual(reactor.currentState.codeInput[4], "")
        XCTAssertEqual(reactor.currentState.cusor, 4)
    }
    
    func test_codeNumberRemove_firstNumber() throws {
        // Given
        let reactor = ChatCodeInputViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                               userData: MockUserDataProvider())
        reactor.action.onNext(.numberButtonTapped("1"))

        // When
        reactor.action.onNext(.removeButtonTapped)

        // Then
        XCTAssertEqual(reactor.currentState.codeInput[0], "")
        XCTAssertEqual(reactor.currentState.cusor, 0)
    }
    
    func test_codeNumberRemove_below_minLength() throws {
        // Given
        let reactor = ChatCodeInputViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                               userData: MockUserDataProvider())

        // When
        reactor.action.onNext(.removeButtonTapped)

        // Then
        XCTAssertEqual(reactor.currentState.codeInput[0], "")
        XCTAssertEqual(reactor.currentState.cusor, 0)
    }
    
    func test_joinChatRoom_success() throws {
        // Given
        let reactor = ChatCodeInputViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                               userData: MockUserDataProvider())
        reactor.action.onNext(.numberButtonTapped("5"))
        reactor.action.onNext(.numberButtonTapped("4"))
        reactor.action.onNext(.numberButtonTapped("5"))
        reactor.action.onNext(.numberButtonTapped("3"))
        reactor.action.onNext(.numberButtonTapped("0"))

        // When
        reactor.action.onNext(.numberButtonTapped("5"))

        // Then
        XCTAssertEqual(reactor.currentState.chatRoomInfo, ChatRoomInfo(userID: 1, roomID: 8, code: "545305", token: "testToken"))
    }
    
    func test_joinChatRoom_fail() throws {
        // Given
        let reactor = ChatCodeInputViewReactor(networkService: MockApolloNetworkServiceFailure(),
                                               userData: MockUserDataProvider())
        reactor.action.onNext(.numberButtonTapped("6"))
        reactor.action.onNext(.numberButtonTapped("3"))
        reactor.action.onNext(.numberButtonTapped("4"))
        reactor.action.onNext(.numberButtonTapped("2"))
        reactor.action.onNext(.numberButtonTapped("1"))

        // When
        reactor.action.onNext(.numberButtonTapped("7"))
        
        // Then
        let code = reactor.currentState.codeInput.reduce("") { $0 + $1 }
        XCTAssertEqual(code, "")
        XCTAssertEqual(reactor.currentState.codeInput[0], "")
        XCTAssertEqual(reactor.currentState.cusor, 0)
    }
}
