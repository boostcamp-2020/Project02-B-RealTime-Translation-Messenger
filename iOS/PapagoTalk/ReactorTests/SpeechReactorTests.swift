//
//  SpeechReactorTests.swift
//  PapagoTalkTests
//
//  Created by Byoung-Hwi Yoon on 2020/12/08.
//

import XCTest
@testable import PapagoTalk

class SpeechReactorTests: XCTestCase {

    func test_microphone_button_tapped() throws {
        // Given
        let reactor = SpeechViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                        userData: MockUserDataProvider(),
                                        speechManager: MockSpeechManager(),
                                        roomID: 1)

        // When
        reactor.action.onNext(.microphoneButtonTapped)

        // Then
        XCTAssertEqual(reactor.currentState.speechRecognizedText, "RecognizedText")
    }
    
    func test_speech_text_changed() throws {
        // Given
        let reactor = SpeechViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                        userData: MockUserDataProvider(),
                                        speechManager: MockSpeechManager(),
                                        roomID: 1)

        // When
        reactor.action.onNext(.speechTextChanged("Changed"))

        // Then
        XCTAssertEqual(reactor.currentState.speechRecognizedText, "Changed")
    }
    
    func test_origin_text_changed() throws {
        // Given
        let reactor = SpeechViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                        userData: MockUserDataProvider(),
                                        speechManager: MockSpeechManager(),
                                        roomID: 1)

        // When
        reactor.action.onNext(.originTextChanged("Changed"))

        // Then
        XCTAssertEqual(reactor.currentState.originText, "Changed")
    }
    
    func test_translated_text_changed() throws {
        // Given
        let reactor = SpeechViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                        userData: MockUserDataProvider(),
                                        speechManager: MockSpeechManager(),
                                        roomID: 1)

        // When
        reactor.action.onNext(.translatedTextChaged("Changed"))

        // Then
        XCTAssertEqual(reactor.currentState.translatedText, "Changed")
    }
    
    func test_speechRecognition_availabilty_changed_to_true() throws {
        // Given
        let reactor = SpeechViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                        userData: MockUserDataProvider(),
                                        speechManager: MockSpeechManager(),
                                        roomID: 1)

        // When
        reactor.action.onNext(.speechRecognitionAvailabiltyChanged(true))

        // Then
        XCTAssertEqual(reactor.currentState.isMicrophoneButtonEnable, true)
    }
    
    func test_speechRecognition_availabilty_changed_to_false() throws {
        // Given
        let reactor = SpeechViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                        userData: MockUserDataProvider(),
                                        speechManager: MockSpeechManager(),
                                        roomID: 1)

        // When
        reactor.action.onNext(.speechRecognitionAvailabiltyChanged(false))

        // Then
        XCTAssertEqual(reactor.currentState.isMicrophoneButtonEnable, false)
    }
    
    func test_origin_send_button_tapped() throws {
        // Given
        let reactor = SpeechViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                        userData: MockUserDataProvider(),
                                        speechManager: MockSpeechManager(),
                                        roomID: 1)

        // When
        reactor.action.onNext(.originSendButtonTapped)

        // Then
        XCTAssertEqual(reactor.currentState.messageDidSend, true)
    }
    
    func test_translated_send_button_tapped() throws {
        // Given
        let reactor = SpeechViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                        userData: MockUserDataProvider(),
                                        speechManager: MockSpeechManager(),
                                        roomID: 1)

        // When
        reactor.action.onNext(.translatedSendButtonTapped)

        // Then
        XCTAssertEqual(reactor.currentState.messageDidSend, true)
    }
    
    func test_text_should_translated_after_originText_changed() throws {
        // Given
        let reactor = SpeechViewReactor(networkService: MockApolloNetworkServiceSuccess(),
                                        userData: MockUserDataProvider(),
                                        speechManager: MockSpeechManager(),
                                        roomID: 1)

        // When
        reactor.action.onNext(.originTextChanged("origin"))

        // Then
        XCTAssertEqual(reactor.currentState.translatedText, "TranslatedText")
    }
}
