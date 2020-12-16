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
    
    func test_parser_should_always_parse_translated_message_when_flag_true() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: true)
        let messageParser = MessageParser(userData: receiver)
        let factory = MockMessageFactory()
        let messages = [factory.message(messageID: 1, senderID: 1, source: "ko"),
                        factory.message(messageID: 2, senderID: 1, source: "en"),
                        factory.message(messageID: 3, senderID: 2, source: "ko"),
                        factory.message(messageID: 4, senderID: 2, source: "en")]
        var parsedMessages: [Message] = []
        // When
        messages.forEach { parsedMessages.append(contentsOf: messageParser.parse(newMessage: $0)) }
        // Then
        XCTAssertEqual(parsedMessages.count, messages.count * 2)
    }
    
    func test_parser_should_always_throw_traslation_failed_messsage() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: true)
        let messageParser = MessageParser(userData: receiver)
        let factory = MockMessageFactory()
        let messages = [factory.translationFailedMessage(messageID: 1, senderID: 1, source: "ko"),
                        factory.translationFailedMessage(messageID: 2, senderID: 1, source: "en"),
                        factory.translationFailedMessage(messageID: 3, senderID: 2, source: "ko"),
                        factory.translationFailedMessage(messageID: 4, senderID: 2, source: "en")]
        var parsedMessages: [Message] = []
        // When
        messages.forEach { parsedMessages.append(contentsOf: messageParser.parse(newMessage: $0)) }
        // Then
        XCTAssertEqual(parsedMessages.count, messages.count)
    }
    
    func test_parse_missing_messages_sent_same_language_flag_true() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: true)
        let messageParser = MessageParser(userData: receiver)
        let factory = MockMessageFactory()
        let messages = [factory.message(messageID: 1, senderID: 1, source: "ko"),
                        factory.message(messageID: 2, senderID: 1, source: "ko"),
                        factory.message(messageID: 3, senderID: 1, source: "ko"),
                        factory.message(messageID: 4, senderID: 1, source: "ko")]
        // When
        let parsedMessages = messageParser.parse(missingMessages: messages)
        // Then
        XCTAssertEqual(parsedMessages.count, messages.count * 2)
    }
    
    func test_parse_missing_messages_sent_same_language_flag_false() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: false)
        let messageParser = MessageParser(userData: receiver)
        let factory = MockMessageFactory()
        let messages = [factory.message(messageID: 1, senderID: 1, source: "ko"),
                        factory.message(messageID: 2, senderID: 1, source: "ko"),
                        factory.message(messageID: 3, senderID: 1, source: "ko"),
                        factory.message(messageID: 4, senderID: 1, source: "ko")]
        // When
        let parsedMessages = messageParser.parse(missingMessages: messages)
        // Then
        XCTAssertEqual(parsedMessages.count, messages.count)
    }
    
    func test_parse_missing_messages_sent_different_language_flag_true() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: true)
        let messageParser = MessageParser(userData: receiver)
        let factory = MockMessageFactory()
        let messages = [factory.message(messageID: 1, senderID: 1, source: "en"),
                        factory.message(messageID: 2, senderID: 1, source: "en"),
                        factory.message(messageID: 3, senderID: 1, source: "en"),
                        factory.message(messageID: 4, senderID: 1, source: "en")]
        // When
        let parsedMessages = messageParser.parse(missingMessages: messages)
        // Then
        XCTAssertEqual(parsedMessages.count, messages.count * 2)
    }
    
    func test_parse_missing_messages_sent_different_language_flag_false() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: false)
        let messageParser = MessageParser(userData: receiver)
        let factory = MockMessageFactory()
        let messages = [factory.message(messageID: 1, senderID: 1, source: "en"),
                        factory.message(messageID: 2, senderID: 1, source: "en"),
                        factory.message(messageID: 3, senderID: 1, source: "en"),
                        factory.message(messageID: 4, senderID: 1, source: "en")]
        // When
        let parsedMessages = messageParser.parse(missingMessages: messages)
        // Then
        XCTAssertEqual(parsedMessages.count, messages.count * 2)
    }
    
    func test_parse_missing_messages_received_same_language_flag_true() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: true)
        let messageParser = MessageParser(userData: receiver)
        let factory = MockMessageFactory()
        let messages = [factory.message(messageID: 1, senderID: 2, source: "ko"),
                        factory.message(messageID: 2, senderID: 3, source: "ko"),
                        factory.message(messageID: 3, senderID: 4, source: "ko"),
                        factory.message(messageID: 4, senderID: 5, source: "ko")]
        // When
        let parsedMessages = messageParser.parse(missingMessages: messages)
        // Then
        XCTAssertEqual(parsedMessages.count, messages.count * 2)
    }
    
    func test_parse_missing_messages_received_same_language_flag_false() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: false)
        let messageParser = MessageParser(userData: receiver)
        let factory = MockMessageFactory()
        let messages = [factory.message(messageID: 1, senderID: 2, source: "ko"),
                        factory.message(messageID: 2, senderID: 3, source: "ko"),
                        factory.message(messageID: 3, senderID: 4, source: "ko"),
                        factory.message(messageID: 4, senderID: 5, source: "ko")]
        // When
        let parsedMessages = messageParser.parse(missingMessages: messages)
        // Then
        XCTAssertEqual(parsedMessages.count, messages.count)
    }
    
    func test_parse_missing_messages_received_different_language_flag_true() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: true)
        let messageParser = MessageParser(userData: receiver)
        let factory = MockMessageFactory()
        let messages = [factory.message(messageID: 1, senderID: 2, source: "en"),
                        factory.message(messageID: 2, senderID: 3, source: "en"),
                        factory.message(messageID: 3, senderID: 4, source: "en"),
                        factory.message(messageID: 4, senderID: 5, source: "en")]
        // When
        let parsedMessages = messageParser.parse(missingMessages: messages)
        // Then
        XCTAssertEqual(parsedMessages.count, messages.count * 2)
    }
    
    func test_parse_missing_messages_received_different_language_flag_false() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: false)
        let messageParser = MessageParser(userData: receiver)
        let factory = MockMessageFactory()
        let messages = [factory.message(messageID: 1, senderID: 2, source: "en"),
                        factory.message(messageID: 2, senderID: 3, source: "en"),
                        factory.message(messageID: 3, senderID: 4, source: "en"),
                        factory.message(messageID: 4, senderID: 5, source: "en")]
        // When
        let parsedMessages = messageParser.parse(missingMessages: messages)
        // Then
        XCTAssertEqual(parsedMessages.count, messages.count * 2)
    }
    
    func test_parse_missing_messages_mixed() throws {
        // Given
        let receiver = MockReceiver(userID: 1,
                                    language: .korean,
                                    sameLanguageTranslation: false)
        let messageParser = MessageParser(userData: receiver)
        let factory = MockMessageFactory()
        let translatedMessages = [factory.message(messageID: 1, senderID: 1, source: "en"),
                                  factory.message(messageID: 2, senderID: 2, source: "en")]
        let noneTranslatedMessages = [factory.message(messageID: 1, senderID: 2, source: "ko"),
                                      factory.message(messageID: 3, senderID: 2, source: "ko"),
                                      factory.message(messageID: 4, senderID: 1, source: "in"),
                                      factory.message(messageID: 5, senderID: 2, source: "out"),
                                      factory.translationFailedMessage(messageID: 6, senderID: 1, source: "ko"),
                                      factory.translationFailedMessage(messageID: 7, senderID: 1, source: "en"),
                                      factory.translationFailedMessage(messageID: 8, senderID: 2, source: "ko"),
                                      factory.translationFailedMessage(messageID: 9, senderID: 2, source: "en")]
        var messages: [MessageData] = []
        messages.append(contentsOf: translatedMessages)
        messages.append(contentsOf: noneTranslatedMessages)
        // When
        let parsedMessages = messageParser.parse(missingMessages: messages)
        // Then
        XCTAssertEqual(parsedMessages.count, messages.count + translatedMessages.count)
    }
}
