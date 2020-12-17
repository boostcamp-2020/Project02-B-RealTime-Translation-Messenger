//
//  SettingReactorTests.swift
//  ReactorTests
//
//  Created by 송민관 on 2020/12/16.
//

import XCTest
@testable import PapagoTalk

class SettingReactorTests: XCTestCase {
    
    func test_selected_small_button() {
        // Given
        let reactor = SettingViewReactor(userData: MockUserDataProvider())

        // When
        reactor.action.onNext(.sizeSegmentedControlChanged(0) )

        // Then
        XCTAssertEqual(reactor.currentState.microphoneButtonState, .big)
    }
    
    func test_selected_medium_button() {
        // Given
        let reactor = SettingViewReactor(userData: MockUserDataProvider())

        // When
        reactor.action.onNext(.sizeSegmentedControlChanged(1) )

        // Then
        XCTAssertEqual(reactor.currentState.microphoneButtonState, .medium)
    }
    
    func test_selected_big_button() {
        // Given
        let reactor = SettingViewReactor(userData: MockUserDataProvider())

        // When
        reactor.action.onNext(.sizeSegmentedControlChanged(2) )

        // Then
        XCTAssertEqual(reactor.currentState.microphoneButtonState, .small)
    }
    
    func test_selected_none_button() {
        // Given
        let reactor = SettingViewReactor(userData: MockUserDataProvider())

        // When
        reactor.action.onNext(.sizeSegmentedControlChanged(3) )

        // Then
        XCTAssertEqual(reactor.currentState.microphoneButtonState, .none)
    }
    
    func test_selected_same_language_traslation_true() {
        // Given
        let reactor = SettingViewReactor(userData: MockUserDataProvider())

        // When
        reactor.action.onNext(.translationSettingSwitchChanged(true) )

        // Then
        XCTAssertEqual(reactor.currentState.translationSetting, true)
    }
    
    func test_selected_same_language_traslation_false() {
        // Given
        let reactor = SettingViewReactor(userData: MockUserDataProvider())

        // When
        reactor.action.onNext(.translationSettingSwitchChanged(false) )

        // Then
        XCTAssertEqual(reactor.currentState.translationSetting, false)
    }
}
