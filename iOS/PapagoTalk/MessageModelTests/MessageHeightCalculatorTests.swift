//
//  MessageHeightCalculatorTests.swift
//  MessageModelTests
//
//  Created by Byoung-Hwi Yoon on 2020/12/16.
//

import XCTest

class MessageHeightCalculatorTests: XCTestCase {
    
    func test_sent_message_when_line_changed() throws {
        // Given
        let calculator = MessageHeightCalculator()
        
        var oneLinemessage = Message(of: "OneLine", by: User())
        oneLinemessage.type = .sentOrigin
        
        var twoLinemessage = Message(of: "OneLine\n", by: User())
        twoLinemessage.type = .sentOrigin
        
        var threeLinemessage = Message(of: "OneLine\n\n", by: User())
        threeLinemessage.type = .sentOrigin
        
        // When
        let oneLineHeight = calculator.height(of: oneLinemessage)
        let twoLineHeight = calculator.height(of: twoLinemessage)
        let threeLineHeight = calculator.height(of: threeLinemessage)
        
        // Then
        XCTAssertGreaterThan(twoLineHeight, oneLineHeight)
        XCTAssertGreaterThan(threeLineHeight, twoLineHeight)
    }
    
    func test_received_message_when_line_changed() throws {
        // Given
        let calculator = MessageHeightCalculator()
        
        var oneLinemessage = Message(of: "OneLine", by: User())
        oneLinemessage.type = .receivedOrigin
        
        var twoLinemessage = Message(of: "OneLine\n", by: User())
        twoLinemessage.type = .receivedOrigin
        
        var threeLinemessage = Message(of: "OneLine\n\n", by: User())
        threeLinemessage.type = .receivedOrigin
        
        // When
        let oneLineHeight = calculator.height(of: oneLinemessage)
        let twoLineHeight = calculator.height(of: twoLinemessage)
        let threeLineHeight = calculator.height(of: threeLinemessage)
        
        // Then
        XCTAssertGreaterThan(twoLineHeight, oneLineHeight)
        XCTAssertGreaterThan(threeLineHeight, twoLineHeight)
    }
    
    func test_sent_translated_message_when_line_changed() throws {
        // Given
        let calculator = MessageHeightCalculator()
        
        var oneLinemessage = Message(of: "OneLine", by: User())
        oneLinemessage.type = .sentTranslated
        
        var twoLinemessage = Message(of: "OneLine\n", by: User())
        twoLinemessage.type = .sentTranslated
        
        var threeLinemessage = Message(of: "OneLine\n\n", by: User())
        threeLinemessage.type = .sentTranslated
        
        // When
        let oneLineHeight = calculator.height(of: oneLinemessage)
        let twoLineHeight = calculator.height(of: twoLinemessage)
        let threeLineHeight = calculator.height(of: threeLinemessage)
        
        // Then
        XCTAssertGreaterThan(twoLineHeight, oneLineHeight)
        XCTAssertGreaterThan(threeLineHeight, twoLineHeight)
    }
    
    func test_received_translated_message_when_line_changed() throws {
        // Given
        let calculator = MessageHeightCalculator()
        
        var oneLinemessage = Message(of: "OneLine", by: User())
        oneLinemessage.type = .receivedTranslated
        
        var twoLinemessage = Message(of: "OneLine\n", by: User())
        twoLinemessage.type = .receivedTranslated
        
        var threeLinemessage = Message(of: "OneLine\n\n", by: User())
        threeLinemessage.type = .receivedTranslated
        
        // When
        let oneLineHeight = calculator.height(of: oneLinemessage)
        let twoLineHeight = calculator.height(of: twoLinemessage)
        let threeLineHeight = calculator.height(of: threeLinemessage)
        
        // Then
        XCTAssertGreaterThan(twoLineHeight, oneLineHeight)
        XCTAssertGreaterThan(threeLineHeight, twoLineHeight)
    }
    
    func test_system_message_has_same_height() throws {
        // Given
        let calculator = MessageHeightCalculator()
        
        var oneLinemessage = Message(of: "OneLine", by: User())
        oneLinemessage.type = .system
        
        var twoLinemessage = Message(of: "OneLine\n", by: User())
        twoLinemessage.type = .system
        
        var threeLinemessage = Message(of: "OneLine\n\n", by: User())
        threeLinemessage.type = .system
        
        // When
        let oneLineHeight = calculator.height(of: oneLinemessage)
        let twoLineHeight = calculator.height(of: twoLinemessage)
        let threeLineHeight = calculator.height(of: threeLinemessage)
        
        // Then
        XCTAssertEqual(twoLineHeight, oneLineHeight)
        XCTAssertEqual(threeLineHeight, twoLineHeight)
    }
}
