//
//  WebSocketServiceProviding.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/13.
//

import Foundation
import RxSwift

protocol WebSocketServiceProviding {
    func getMessage() -> Observable<GetMessageSubscription.Data>
    func reconnect()
}
