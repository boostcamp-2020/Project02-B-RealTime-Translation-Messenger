//
//  HomeReactorTests.swift
//  PapagoTalkTests
//
//  Created by 송민관 on 2020/12/08.
//

import XCTest
@testable import PapagoTalk

class HomeReactorTests: XCTestCase {

    func test_changeProfileImage() throws {
        // Given
        let reactor = HomeViewReactor(networkService: MockNetworkServiceSuccess(),
                                      userData: MockUserDataProvider(),
                                      imageFactory: StubImageFactory())

        // When
        reactor.action.onNext(.profileImageTapped)

        // Then
        XCTAssertEqual(reactor.currentState.profileImageURL, "1.png")
    }

    func test_changeNickName() throws {
        // Given
        let reactor = HomeViewReactor(networkService: MockNetworkServiceSuccess(),
                                      userData: MockUserDataProvider())

        // When
        reactor.action.onNext(.nickNameChanged("test"))

        // Then
        XCTAssertEqual(reactor.currentState.nickName, "test")
    }

    func test_selectLanguage() throws {
        // Given
        let reactor = HomeViewReactor(networkService: MockNetworkServiceSuccess(),
                                      userData: MockUserDataProvider())

        // When
        reactor.action.onNext(.languageSelected(.english))

        // Then
        XCTAssertEqual(reactor.currentState.language, .english)
    }
    
    func test_blockNickNameMaxLength() throws {
        // Given
        let userMock = MockUserDataProvider(nickName: "abcdefghijklmnop")
        let reactor = HomeViewReactor(networkService: MockNetworkServiceSuccess(),
                                      userData: userMock)

        // When
        reactor.action.onNext(.nickNameChanged(userMock.nickName))

        // Then
        XCTAssertEqual(reactor.currentState.needShake.data, true)
        XCTAssertEqual(reactor.currentState.nickName.count, 12)
    }

    func test_makeChatRoom_success() throws {
        // Given
        let reactor = HomeViewReactor(networkService: MockNetworkServiceSuccess(),
                                      userData: MockUserDataProvider())

        // When
        reactor.action.onNext(.makeChatRoomButtonTapped)

        // Then
        XCTAssertEqual(reactor.currentState.createRoomResponse,
                       .init(userId: 1, roomId: 8, code: "545305", token: "testToken"))
    }
    
    func test_makeChatRoom_invalidNickName() throws {
        // Given
        let userMock = MockUserDataProvider(nickName: "a")
        let reactor = HomeViewReactor(networkService: MockNetworkServiceFailure(),
                                      userData: userMock)

        // When
        reactor.action.onNext(.makeChatRoomButtonTapped)

        // Then
        XCTAssertEqual(reactor.currentState.createRoomResponse, nil)
        XCTAssertEqual(reactor.currentState.errorMessage.data, Strings.Home.invalidNickNameAlertMessage)
    }
    
    func test_makeChatRoom_fail() throws {
        // Given
        let reactor = HomeViewReactor(networkService: MockNetworkServiceFailure(),
                                      userData: MockUserDataProvider())

        // When
        reactor.action.onNext(.makeChatRoomButtonTapped)

        // Then
        XCTAssertEqual(reactor.currentState.createRoomResponse, nil)
        XCTAssertEqual(reactor.currentState.errorMessage.data, HomeError.networkError.message)
    }

    func test_joinChatRoom() throws {
        // Given
        let reactor = HomeViewReactor(networkService: MockNetworkServiceSuccess(),
                                      userData: MockUserDataProvider())

        // When
        reactor.action.onNext(.joinChatRoomButtonTapped)

        // Then
        XCTAssertEqual(reactor.currentState.joinRoom.data, true)
    }
    
    func test_joinChatRoom_invalidNickName() throws {
        // Given
        let userMock = MockUserDataProvider(nickName: "a")
        let reactor = HomeViewReactor(networkService: MockNetworkServiceFailure(),
                                      userData: userMock)

        // When
        reactor.action.onNext(.joinChatRoomButtonTapped)

        // Then
        XCTAssertEqual(reactor.currentState.joinRoom.data, false)
        XCTAssertEqual(reactor.currentState.errorMessage.data, Strings.Home.invalidNickNameAlertMessage)
    }
}
