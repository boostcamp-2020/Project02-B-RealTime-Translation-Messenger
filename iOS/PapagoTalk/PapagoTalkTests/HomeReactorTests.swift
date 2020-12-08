//
//  HomeReactorTests.swift
//  PapagoTalkTests
//
//  Created by 송민관 on 2020/12/08.
//

import XCTest

class HomeReactorTests: XCTestCase {

    func test_changeProfileImage() throws {
        // Given
        let reactor = HomeViewReactor(networkService: ApolloNetworkServiceMockSuccess(),
                                      userData: UserDataProviderMock(),
                                      imageFactory: ImageFactoryStub())

        // When
        reactor.action.onNext(.profileImageTapped)

        // Then
        XCTAssertEqual(reactor.currentState.profileImageURL, "1.png")
    }

    func test_changeNickName() throws {
        // Given
        let reactor = HomeViewReactor(networkService: ApolloNetworkServiceMockSuccess(),
                                      userData: UserDataProviderMock())

        // When
        reactor.action.onNext(.nickNameChanged("test"))

        // Then
        XCTAssertEqual(reactor.currentState.nickName, "test")
    }

    func test_selectLanguage() throws {
        // Given
        let reactor = HomeViewReactor(networkService: ApolloNetworkServiceMockSuccess(),
                                      userData: UserDataProviderMock())

        // When
        reactor.action.onNext(.languageSelected(.english))

        // Then
        XCTAssertEqual(reactor.currentState.language, .english)
    }
    
    
}
