//
//  MessageModelTests.swift
//  MessageModelTests
//
//  Created by Byoung-Hwi Yoon on 2020/12/16.
//

import XCTest

class MessageBoxTests: XCTestCase {
    
    func test_append_messages() throws {
        // Given
        let messageBox = MessageBox()
        let messages = [
            Message(of: "test1", by: User()),
            Message(of: "test2", by: User()),
            Message(of: "test3", by: User()),
            Message(of: "test4", by: User()),
            Message(of: "test5", by: User())
        ]
        
        // When
        messageBox.append(messages)

        // Then
        XCTAssertEqual(messageBox.messages.count, 5)
    }
    
    func test_append_when_lastMessage_not_exist() throws {
        // Given
        let messageBox = MessageBox()
        let message = Message(of: "test", by: User())

        // When
        messageBox.append(message)

        // Then
        XCTAssertEqual(messageBox.messages.first?.text, "test")
    }
    
    func test_append_isAppropriateMessage_true() throws {
        // Given
        let messageBox = MessageBox()
        let message = Message(of: "test", by: User())
        messageBox.append(message)

        // When
        messageBox.append(message)

        // Then
        XCTAssertEqual(messageBox.messages.count, 2)
    }
    
    func test_append_isAppropriateMessage_false() throws {
        // Given
        let messageBox = MessageBox()
        let message = Message(of: "test", by: User())
        let mockMessageData = MockMessageData()
        let mockTranslatedResult = TranslatedResult(originText: "", translatedText: "")
        let newMessage = Message(data: mockMessageData, with: mockTranslatedResult, timeStamp: "1000000000000")
        messageBox.append(message)

        // When
        messageBox.append(newMessage)

        // Then
        XCTAssertEqual(messageBox.messages.count, 1)
    }
    
    func test_append_setMessageIsFirst_when_true() throws {
        // Given
        let messageBox = MessageBox()
        let mockMessageData = MockMessageData()
        let mockTranslatedResult = TranslatedResult(originText: "", translatedText: "")
        let message = Message(data: mockMessageData, with: mockTranslatedResult, timeStamp: "")

        // When
        messageBox.append(message)

        // Then
        XCTAssertEqual(messageBox.messages.last?.isFirstOfDay, true)
    }
    
    func test_append_setMessageIsFirst_when_false() throws {
        // Given
        let messageBox = MessageBox()
        let mockMessageData = MockMessageData()
        let mockTranslatedResult = TranslatedResult(originText: "", translatedText: "")
        let message = Message(data: mockMessageData, with: mockTranslatedResult, timeStamp: "")
        messageBox.append(message)

        // When
        messageBox.append(message)

        // Then
        XCTAssertEqual(messageBox.messages.last?.isFirstOfDay, false)
    }
    
    func test_append_setShouldImageShow_when_true() throws {
        // Given
        let messageBox = MessageBox()
        let mockMessageData = MockMessageData()
        let mockTranslatedResult = TranslatedResult(originText: "", translatedText: "")
        let message = Message(data: mockMessageData, with: mockTranslatedResult, timeStamp: "")

        // When
        messageBox.append(message)

        // Then
        XCTAssertEqual(messageBox.messages.last?.shouldImageShow, true)
    }
    
    func test_append_setShouldImageShow_when_false() throws {
        // Given
        let messageBox = MessageBox()
        let mockMessageData = MockMessageData()
        let mockTranslatedResult = TranslatedResult(originText: "", translatedText: "")
        let message = Message(data: mockMessageData, with: mockTranslatedResult, timeStamp: "")
        messageBox.append(message)
        
        // When
        messageBox.append(message)

        // Then
        XCTAssertEqual(messageBox.messages.last?.shouldImageShow, false)
    }
    
    func test_append_setShouldTimeShow_when_first() throws {
        // Given
        let messageBox = MessageBox()
        let mockMessageData = MockMessageData()
        let mockTranslatedResult = TranslatedResult(originText: "", translatedText: "")
        let message = Message(data: mockMessageData, with: mockTranslatedResult, timeStamp: "1234567890123")

        // When
        messageBox.append(message)

        // Then
        XCTAssertEqual(messageBox.messages.last?.shouldTimeShow, true)
    }
    
    func test_append_setShouldTimeShow_when_second_true() throws {
        // Given
        let messageBox = MessageBox()
        let mockMessageData = MockMessageData()
        let mockTranslatedResult = TranslatedResult(originText: "", translatedText: "")
        let message = Message(data: mockMessageData, with: mockTranslatedResult, timeStamp: "1234567890123")
        messageBox.append(message)
        
        // When
        messageBox.append(message)

        // Then
        XCTAssertEqual(messageBox.messages.first?.shouldTimeShow, false)
        XCTAssertEqual(messageBox.messages.last?.shouldTimeShow, true)
    }
    
    func test_append_setShouldTimeShow_when_second_different_sender() throws {
        // Given
        let messageBox = MessageBox()
        let mockUserData = MockUserData(id: 0, nickname: "sender1", avatar: "", lang: "")
        let mockMessageData = MockMessageData(userData: mockUserData)
        let mockTranslatedResult = TranslatedResult(originText: "", translatedText: "")
        let message = Message(data: mockMessageData, with: mockTranslatedResult, timeStamp: "1234567890123")
        messageBox.append(message)
        
        let secondMockUserData = MockUserData(id: 1, nickname: "sender2", avatar: "", lang: "")
        let secondMockMessageData = MockMessageData(userData: secondMockUserData)
        let secondMessage = Message(data: secondMockMessageData, with: mockTranslatedResult, timeStamp: "1234567890123")
        
        // When
        messageBox.append(secondMessage)

        // Then
        XCTAssertEqual(messageBox.messages.first?.shouldTimeShow, true)
        XCTAssertEqual(messageBox.messages.last?.shouldTimeShow, true)
    }
    
    func test_append_setShouldTimeShow_when_second_different_time() throws {
        // Given
        let messageBox = MessageBox()
        let mockMessageData = MockMessageData()
        let mockTranslatedResult = TranslatedResult(originText: "", translatedText: "")
        let message = Message(data: mockMessageData, with: mockTranslatedResult, timeStamp: "1234567890123")
        messageBox.append(message)
        
        let secondMockMessageData = MockMessageData()
        let secondMessage = Message(data: secondMockMessageData, with: mockTranslatedResult, timeStamp: "123459999999")
        
        // When
        messageBox.append(secondMessage)

        // Then
        XCTAssertEqual(messageBox.messages.first?.shouldTimeShow, true)
        XCTAssertEqual(messageBox.messages.last?.shouldTimeShow, true)
    }
    
    
}
