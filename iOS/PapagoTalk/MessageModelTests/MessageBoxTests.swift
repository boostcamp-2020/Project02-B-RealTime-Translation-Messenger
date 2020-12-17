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
    
    
}
