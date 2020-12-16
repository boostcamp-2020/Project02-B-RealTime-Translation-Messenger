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
        oneLinemessage.type = .sent
        
        var twoLinemessage = Message(of: "OneLine\n", by: User())
        twoLinemessage.type = .sent
        
        var threeLinemessage = Message(of: "OneLine\n\n", by: User())
        threeLinemessage.type = .sent
        
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
        oneLinemessage.type = .received
        
        var twoLinemessage = Message(of: "OneLine\n", by: User())
        twoLinemessage.type = .received
        
        var threeLinemessage = Message(of: "OneLine\n\n", by: User())
        threeLinemessage.type = .received
        
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
        oneLinemessage.type = .translated
        
        var twoLinemessage = Message(of: "OneLine\n", by: User())
        twoLinemessage.type = .translated
        
        var threeLinemessage = Message(of: "OneLine\n\n", by: User())
        threeLinemessage.type = .translated
        
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
