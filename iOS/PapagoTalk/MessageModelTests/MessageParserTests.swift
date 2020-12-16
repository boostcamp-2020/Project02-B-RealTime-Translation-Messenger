//
//  MessageParserTests.swift
//  MessageModelTests
//
//  Created by Byoung-Hwi Yoon on 2020/12/16.
//

import XCTest

class MessageParserTests: XCTestCase {
    func test_originTextParsing() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: true)
        let messageParser = MessageParser(userData: receiver)
        
        let message = MockMessageFactory().message(messageID: 1, senderID: 2, source: "en")
        
        // When
        
        let originText = messageParser.parse(newMessage: message).first?.text
        
        // Then
        XCTAssertEqual(originText, "OriginText")
    }
    
    func test_translatedTextParsing() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: true)
        let messageParser = MessageParser(userData: receiver)
        
        let message = MockMessageFactory().message(messageID: 1, senderID: 2, source: "en")
        
        // When
        
        let translatedText = messageParser.parse(newMessage: message).last?.text
        
        // Then
        XCTAssertEqual(translatedText, "TranslatedText")
    }
    
    func test_parser_should_not_parse_system_in_message() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: true)
        let messageParser = MessageParser(userData: receiver)
        
        let message = MockMessageFactory().message(messageID: 1, senderID: 2, source: "in")
        // When
        let parsedMessage = messageParser.parse(newMessage: message)
        // Then
        XCTAssertEqual(parsedMessage.count, 1)
        XCTAssertEqual(parsedMessage[0].type, .system)
    }
    
    func test_parser_should_not_parse_system_out_message() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: true)
        let messageParser = MessageParser(userData: receiver)
        
        let message = MockMessageFactory().message(messageID: 1, senderID: 2, source: "out")
        // When
        let parsedMessage = messageParser.parse(newMessage: message)
        // Then
        XCTAssertEqual(parsedMessage.count, 1)
        XCTAssertEqual(parsedMessage[0].type, .system)
    }
    
    func test_parse_sent_message_when_language_different() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: true)
        let messageParser = MessageParser(userData: receiver)
        
        let message = MockMessageFactory().message(messageID: 1, senderID: 1, source: "en")
        // When
        let parsedMessage = messageParser.parse(newMessage: message)
        // Then
        XCTAssertEqual(parsedMessage.count, 2)
        XCTAssertEqual(parsedMessage[0].text, "OriginText")
        XCTAssertEqual(parsedMessage[1].text, "TranslatedText")
    }
    
    func test_parse_sent_message_when_language_same() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: true)
        let messageParser = MessageParser(userData: receiver)
        
        let message = MockMessageFactory().message(messageID: 1, senderID: 1, source: "ko")
        // When
        let parsedMessage = messageParser.parse(newMessage: message)
        // Then
        XCTAssertEqual(parsedMessage.count, 2)
        XCTAssertEqual(parsedMessage[0].text, "OriginText")
        XCTAssertEqual(parsedMessage[1].text, "TranslatedText")
    }
    
    func test_parser_should_not_parse_same_language_when_flag_false() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: false)
        let messageParser = MessageParser(userData: receiver)
        
        let message = MockMessageFactory().message(messageID: 1, senderID: 1, source: "ko")
        // When
        let parsedMessage = messageParser.parse(newMessage: message)
        // Then
        XCTAssertEqual(parsedMessage.count, 1)
        XCTAssertEqual(parsedMessage[0].text, "OriginText")
    }
    
    func test_parser_should_parse_same_language_when_flag_true() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: true)
        let messageParser = MessageParser(userData: receiver)
        
        let message = MockMessageFactory().message(messageID: 1, senderID: 1, source: "ko")
        // When
        let parsedMessage = messageParser.parse(newMessage: message)
        // Then
        XCTAssertEqual(parsedMessage.count, 2)
        XCTAssertEqual(parsedMessage[0].text, "OriginText")
        XCTAssertEqual(parsedMessage[1].text, "TranslatedText")
    }
    
    func test_parse_received_message_when_language_different() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: true)
        let messageParser = MessageParser(userData: receiver)
        
        let message = MockMessageFactory().message(messageID: 1, senderID: 2, source: "en")
        // When
        let parsedMessage = messageParser.parse(newMessage: message)
        // Then
        XCTAssertEqual(parsedMessage.count, 2)
        XCTAssertEqual(parsedMessage[0].text, "OriginText")
        XCTAssertEqual(parsedMessage[1].text, "TranslatedText")
    }
    
    func test_parse_received_message_when_language_same() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: true)
        let messageParser = MessageParser(userData: receiver)
        
        let message = MockMessageFactory().message(messageID: 1, senderID: 2, source: "ko")
        // When
        let parsedMessage = messageParser.parse(newMessage: message)
        // Then
        XCTAssertEqual(parsedMessage.count, 2)
        XCTAssertEqual(parsedMessage[0].text, "OriginText")
        XCTAssertEqual(parsedMessage[1].text, "TranslatedText")
    }
    
    func test_parser_should_not_parse_same_language_when_flag_false_received() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: false)
        let messageParser = MessageParser(userData: receiver)
        
        let message = MockMessageFactory().message(messageID: 1, senderID: 2, source: "ko")
        // When
        let parsedMessage = messageParser.parse(newMessage: message)
        // Then
        XCTAssertEqual(parsedMessage.count, 1)
        XCTAssertEqual(parsedMessage[0].text, "OriginText")
    }
    
    func test_parser_should_parse_same_language_when_flag_true_received() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: true)
        let messageParser = MessageParser(userData: receiver)
        
        let message = MockMessageFactory().message(messageID: 1, senderID: 2, source: "ko")
        // When
        let parsedMessage = messageParser.parse(newMessage: message)
        // Then
        XCTAssertEqual(parsedMessage.count, 2)
        XCTAssertEqual(parsedMessage[0].text, "OriginText")
        XCTAssertEqual(parsedMessage[1].text, "TranslatedText")
    }
}
