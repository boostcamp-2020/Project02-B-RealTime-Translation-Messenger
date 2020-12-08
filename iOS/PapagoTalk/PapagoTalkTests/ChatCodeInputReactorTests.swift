//
//  ChatCodeInputReactorTests.swift
//  PapagoTalkTests
//
//  Created by 송민관 on 2020/12/08.
//

import XCTest

class ChatCodeInputReactorTests: XCTestCase {

    func test_codeNumberInput_firstNumber() throws {
        // Given
        let reactor = ChatCodeInputViewReactor(networkService: ApolloNetworkServiceMockSuccess(),
                                               userData: UserDataProviderMock())
        
        // When
        reactor.action.onNext(.numberButtonTapped("5"))
        
        // Then
        XCTAssertEqual(reactor.currentState.codeInput[0], "5")
        XCTAssertEqual(reactor.currentState.cusor, 1)
    }
    
    func test_codeNumberInput_thirdNumber() throws {
        // Given
        let reactor = ChatCodeInputViewReactor(networkService: ApolloNetworkServiceMockSuccess(),
                                               userData: UserDataProviderMock())
        reactor.action.onNext(.numberButtonTapped("5"))
        reactor.action.onNext(.numberButtonTapped("4"))

        // When
        reactor.action.onNext(.numberButtonTapped("5"))

        // Then
        XCTAssertEqual(reactor.currentState.codeInput[2], "5")
        XCTAssertEqual(reactor.currentState.cusor, 3)
    }
    
    func test_codeNumberInput_sixthNumber() throws {
        // Given
        let reactor = ChatCodeInputViewReactor(networkService: ApolloNetworkServiceMockSuccess(),
                                               userData: UserDataProviderMock())
        reactor.action.onNext(.numberButtonTapped("8"))
        reactor.action.onNext(.numberButtonTapped("9"))
        reactor.action.onNext(.numberButtonTapped("0"))
        reactor.action.onNext(.numberButtonTapped("1"))
        reactor.action.onNext(.numberButtonTapped("2"))

        // When
        reactor.action.onNext(.numberButtonTapped("3"))

        // Then
        XCTAssertEqual(reactor.currentState.codeInput[5], "3")
        XCTAssertEqual(reactor.currentState.cusor, 6)
    }
    
    func test_codeNumberInput_above_maxLength() throws {
        // Given
        let reactor = ChatCodeInputViewReactor(networkService: ApolloNetworkServiceMockSuccess(),
                                               userData: UserDataProviderMock())
        reactor.action.onNext(.numberButtonTapped("1"))
        reactor.action.onNext(.numberButtonTapped("2"))
        reactor.action.onNext(.numberButtonTapped("3"))
        reactor.action.onNext(.numberButtonTapped("4"))
        reactor.action.onNext(.numberButtonTapped("5"))
        reactor.action.onNext(.numberButtonTapped("6"))

        // When
        reactor.action.onNext(.numberButtonTapped("7"))

        // Then
        XCTAssertEqual(reactor.currentState.codeInput[5], "6")
        XCTAssertEqual(reactor.currentState.codeInput.count, 6)
        XCTAssertEqual(reactor.currentState.cusor, 6)
    }
    
    
}
