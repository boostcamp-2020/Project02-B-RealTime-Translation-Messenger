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
    
    func test_blockNickNameMaxLength() throws {
        // Given
        let userMock = UserDataProviderMock(nickName: "abcdefghijklmnop")
        let reactor = HomeViewReactor(networkService: ApolloNetworkServiceMockSuccess(),
                                      userData: userMock)

        // When
        reactor.action.onNext(.nickNameChanged(userMock.nickName))

        // Then
        XCTAssertEqual(reactor.currentState.needShake.data, true)
        XCTAssertEqual(reactor.currentState.nickName.count, 12)
    }

    
}
