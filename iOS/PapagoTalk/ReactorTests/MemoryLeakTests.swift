//
//  MemoryLeakTests.swift
//  PupagoTests
//
//  Created by 김종원 on 2020/12/03.
//

import XCTest
import RxSwift
import RxRelay
@testable import PapagoTalk

class MemoryLeakTests: XCTestCase {
    
    lazy var onceToken: NSObject = {
        Resolver.setupForMemoryLeakTest()
        return NSObject()
    }()
   
    override func setUpWithError() throws {
        _ = onceToken
    }
    
    func testLaunchScreenViewControllerIsLeak() {
        XCTAssertLeak(viewController: LaunchScreenViewController.self)
    }
    
    func testHomeViewControllerIsLeak() {
        XCTAssertLeak(viewController: HomeViewController.self)
    }
    
    func testLanguageSelectionViewControllerIsLeak() {
        XCTAssertLeak(viewController: LanguageSelectionViewController.self)
    }
    
    func testHistoryViewControllerIsLeak() {
        XCTAssertLeak(viewController: HistoryViewController.self)
    }
    
    func testChatCodeInputViewControllerIsLeak() {
        XCTAssertLeak(viewController: ChatCodeInputViewController.self)
    }

    func testChatViewControllerIsLeak() {
        XCTAssertLeak(viewController: ChatViewController.self)
    }
    
    func testChatDrawerViewControllerIsLeak() {
        XCTAssertLeak(viewController: ChatDrawerViewController.self)
    }
    
    func testSpeechViewControllerIsLeak() {
        XCTAssertLeak(viewController: SpeechViewController.self)
    }

    func testSettingViewControllerIsLeak() {
        XCTAssertLeak(viewController: SettingViewController.self)
    }
}

extension LaunchScreenViewController: MemoryLeakCheckable, StoryboardInstantiatible, Resolvable {}
extension HomeViewController: MemoryLeakCheckable, StoryboardInstantiatible, Resolvable {}
extension LanguageSelectionViewController: MemoryLeakCheckable, StoryboardInstantiatible, Resolvable {}
extension HistoryViewController: MemoryLeakCheckable, StoryboardInstantiatible, Resolvable {}
extension ChatCodeInputViewController: MemoryLeakCheckable, StoryboardInstantiatible, Resolvable {}
extension ChatViewController: MemoryLeakCheckable, StoryboardInstantiatible, Resolvable {}
extension ChatDrawerViewController: MemoryLeakCheckable, StoryboardInstantiatible, Resolvable {}
extension SpeechViewController: MemoryLeakCheckable, StoryboardInstantiatible, Resolvable {}
extension SettingViewController: MemoryLeakCheckable, StoryboardInstantiatible, Resolvable {}

extension Resolver {
    
    static func setupForMemoryLeakTest() {
        Resolver.shared
            .regist { _ in MockApolloNetworkServiceSuccess() } // networkService
            .regist { _ in MockWebSocketService() }
            .regist { _ in MockUserDataProvider() }
            .regist { _ in MockMessageParser() }
            .regist { _ in MockSpeechManager() }
            .regist { _ in MockHistoryManager() }
            .regist { _ in StubAlertFactory() }
            .regist { _ in
                LaunchScreenViewController.instantiate {
                    LaunchScreenViewController(coder: $0)
                }
            }
            .regist {
                HomeViewReactor(
                    networkService: $0.resolve(MockApolloNetworkServiceSuccess.self),
                    userData: $0.resolve(MockUserDataProvider.self)
                )
            }
            .regist { resolver in
                HomeViewController.instantiate {
                    HomeViewController(
                        coder: $0,
                        reactor: resolver.resolve(HomeViewReactor.self),
                        alertFactory: resolver.resolve(StubAlertFactory.self),
                        currentLanguage: resolver.resolve(MockUserDataProvider.self).language
                    )
                }
            }
            .regist { resolver in
                LanguageSelectionViewController.instantiate {
                    LanguageSelectionViewController(
                        coder: $0,
                        userData: resolver.resolve(MockUserDataProvider.self),
                        observer: BehaviorSubject<Language>(value: .korean)
                    )
                }
            }
            .regist {
                HistoryViewReactor(
                    networkService: $0.resolve(MockApolloNetworkServiceSuccess.self),
                    userData: $0.resolve(MockUserDataProvider.self),
                    historyManager: MockHistoryManager()
                )
            }
            .regist { resolver in
                HistoryViewController.instantiate {
                    HistoryViewController(
                        coder: $0,
                        reactor: resolver.resolve(HistoryViewReactor.self),
                        alertFactory: resolver.resolve(StubAlertFactory.self)
                    )
                }
            }
            .regist {
                ChatCodeInputViewReactor(
                    networkService: $0.resolve(MockApolloNetworkServiceSuccess.self),
                    userData: $0.resolve(MockUserDataProvider.self)
                )
            }
            .regist { resolver in
                ChatCodeInputViewController.instantiate {
                    ChatCodeInputViewController(
                        coder: $0,
                        reactor: resolver.resolve(ChatCodeInputViewReactor.self),
                        alertFactory: resolver.resolve(StubAlertFactory.self)
                    )
                }
            }
            .regist {
                ChatViewReactor(
                    networkService: $0.resolve(MockApolloNetworkServiceSuccess.self),
                    userData: $0.resolve(MockUserDataProvider.self),
                    messageParser: $0.resolve(MockMessageParser.self),
                    chatWebSocket: MockWebSocketService(),
                    historyManager: MockHistoryManager(),
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
                            value: resolver.resolve(MockUserDataProvider.self).micButtonSize
                        )
                    )
                }
            }
            .regist {
                ChatDrawerViewReactor(
                    networkService: $0.resolve(MockApolloNetworkServiceSuccess.self),
                    userData: $0.resolve(MockUserDataProvider.self),
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
                    networkService: $0.resolve(MockApolloNetworkServiceSuccess.self),
                    userData: $0.resolve(MockUserDataProvider.self),
                    speechManager: $0.resolve(MockSpeechManager.self),
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
            .regist {
                SettingViewReactor(
                    userData: $0.resolve(MockUserDataProvider.self)
                )
            }
            .regist { resolver in
                SettingViewController.instantiate {
                    SettingViewController(
                        coder: $0,
                        reactor: resolver.resolve(SettingViewReactor.self),
                        micButtonObserver: BehaviorRelay(value: .none)
                    )
                }
            }
    }
}
