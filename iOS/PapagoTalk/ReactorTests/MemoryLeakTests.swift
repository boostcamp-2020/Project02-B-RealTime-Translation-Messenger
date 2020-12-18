//
//  MemoryLeakTests.swift
//  PupagoTests
//
//  Created by 김종원 on 2020/12/03.
//

import XCTest
@testable import PapagoTalk
import RxSwift
import RxRelay

class MemoryLeakTests: XCTestCase {
    
    lazy var onceToken: NSObject = {
        Resolver.setupForMemoryLeakTest()
        return NSObject()
    }()
   
    override func setUpWithError() throws {
        _ = onceToken
    }
    
    func testHomeViewControllerIsLeak() {
        XCTAssertLeak(viewController: HomeViewController.self)
    }

    func testChatViewControllerIsLeak() {
        XCTAssertLeak(viewController: ChatViewController.self)
    }
    
    func testLanguageSelectionViewControllerIsLeak() {
        XCTAssertLeak(viewController: LanguageSelectionViewController.self)
    }
    
    func testChatCodeInputViewControllerIsLeak() {
        XCTAssertLeak(viewController: ChatCodeInputViewController.self)
    }

    func testChatDrawerViewControllerIsLeak() {
        XCTAssertLeak(viewController: ChatDrawerViewController.self)
    }

    func testSpeechViewControllerIsLeak() {
        XCTAssertLeak(viewController: SpeechViewController.self)
    }
    
}

extension HomeViewController: MemoryLeakCheckable, StoryboardInstantiatible, Resolvable {}
extension ChatViewController: MemoryLeakCheckable, StoryboardInstantiatible, Resolvable {}
extension LanguageSelectionViewController: MemoryLeakCheckable, StoryboardInstantiatible, Resolvable {}
extension ChatCodeInputViewController: MemoryLeakCheckable, StoryboardInstantiatible, Resolvable {}
extension ChatDrawerViewController: MemoryLeakCheckable, StoryboardInstantiatible, Resolvable {}
extension SpeechViewController: MemoryLeakCheckable, StoryboardInstantiatible, Resolvable {}

extension Resolver {
    
    static func setupForMemoryLeakTest() {
        Resolver.shared
            .regist { _ in ApolloNetworkServiceMockSuccess() } // networkService
            .regist { _ in AlertFactoryStub() }
            .regist { _ in UserDataProviderMock() }
            .regist { _ in PapagoAPIManager() } // translationManager
            .regist { SpeechManager(userData: $0.resolve(UserDataProviderMock.self)) }
            .regist { MessageParser(userData: $0.resolve(UserDataProviderMock.self)) }
            .regist {
                HomeViewReactor(
                    networkService: $0.resolve(ApolloNetworkServiceMockSuccess.self),
                    userData: $0.resolve(UserDataProviderMock.self)
                )
            }
            .regist { resolver in
                HomeViewController.instantiate {
                    HomeViewController(
                        coder: $0,
                        reactor: resolver.resolve(HomeViewReactor.self),
                        alertFactory: resolver.resolve(AlertFactoryStub.self),
                        currentLanguage: resolver.resolve(UserDataProviderMock.self).language
                    )
                }
            }
            .regist {
                ChatViewReactor(
                    networkService: $0.resolve(ApolloNetworkServiceMockSuccess.self),
                    userData: $0.resolve(UserDataProviderMock.self),
                    messageParser: $0.resolve(MessageParser.self),
                    roomID: 0,
                    code: "0000"
                )
            }
            .regist { resolver in
                ChatViewController.instantiate {
                    ChatViewController(
                        coder: $0,
                        reactor: resolver.resolve(ChatViewReactor.self),
                        micButtonObserver: BehaviorRelay(
                            value: resolver.resolve(UserDataProviderMock.self).micButtonSize
                        )
                    )
                }
            }
            .regist { resolver in
                LanguageSelectionViewController.instantiate {
                    LanguageSelectionViewController(
                        coder: $0,
                        userData: resolver.resolve(UserDataProviderMock.self),
                        observer: BehaviorSubject<Language>(value: .korean)
                    )
                }
            }
            .regist {
                ChatCodeInputViewReactor(
                    networkService: $0.resolve(ApolloNetworkServiceMockSuccess.self),
                    userData: $0.resolve(UserDataProviderMock.self)
                )
            }
            .regist { resolver in
                ChatCodeInputViewController.instantiate {
                    ChatCodeInputViewController(
                        coder: $0,
                        reactor: resolver.resolve(ChatCodeInputViewReactor.self),
                        alertFactory: resolver.resolve(AlertFactoryStub.self)
                    )
                }
            }
            .regist {
                ChatDrawerViewReactor(
                    networkService: $0.resolve(ApolloNetworkServiceMockSuccess.self),
                    userData: $0.resolve(UserDataProviderMock.self),
                    roomID: 0,
                    roomCode: "0000"
                )
            }
            .regist { resolver in
                ChatDrawerViewController.instantiate {
                    ChatDrawerViewController(
                        coder: $0,
                        reactor: resolver.resolve(ChatDrawerViewReactor.self),
                        visualEffectView: UIVisualEffectView(),
                        stateObserver: BehaviorRelay(value: true),
                        buttonSizeObserver: BehaviorRelay(value: MicButtonSize.big)
                    )
                }
            }
            .regist {
                SpeechViewReactor(
                    networkService: $0.resolve(ApolloNetworkServiceMockSuccess.self),
                    userData: $0.resolve(UserDataProviderMock.self),
                    translationManager: $0.resolve(PapagoAPIManager.self),
                    speechManager: $0.resolve(SpeechManager.self),
                    roomID: 0
                )
            }
            .regist { resolver in
                SpeechViewController.instantiate {
                    SpeechViewController(
                        coder: $0,
                        reactor: resolver.resolve(SpeechViewReactor.self)
                    )
                }
            }
    }
    
}
