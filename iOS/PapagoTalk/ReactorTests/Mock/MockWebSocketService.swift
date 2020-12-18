//
//  MockWebSocketService.swift
//  ReactorTests
//
//  Created by 송민관 on 2020/12/17.
//

import Foundation
import RxSwift
@testable import PapagoTalk

final class MockWebSocketService: WebSocketServiceProviding {
    func getMessage() -> Observable<GetMessageSubscription.Data> {
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
        
    }
}
