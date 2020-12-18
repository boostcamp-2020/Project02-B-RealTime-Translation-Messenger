//
//  MockWebSocketService.swift
//  ReactorTests
//
//  Created by 송민관 on 2020/12/17.
//

import XCTest
import Foundation
import RxSwift
@testable import PapagoTalk

final class MockWebSocketService: WebSocketServiceProviding {

    var isConnected: Bool = false
    
    func getMessage() -> Observable<GetMessageSubscription.Data> {
        isConnected = true
        return .just(.init(newMessage: .init(id: 0,
                                             text: "",
                                             source: "",
                                             createdAt: "",
                                             user: .init(id: 0,
                                                         nickname: "",
                                                         avatar: "",
                                                         lang: ""))))
    }
    
    func reconnect() {
        isConnected ? XCTAssert(true) : XCTAssert(false)
    }
}
