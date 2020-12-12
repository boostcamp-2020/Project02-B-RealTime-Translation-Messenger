//
//  ChatWebSocket.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/11.
//

import Apollo
import RxSwift

final class ChatWebSocket {
    
    let store = ApolloStore()
    var socketURL = APIEndPoint.socketURL
    
    private lazy var webSocketTransport: WebSocketTransport = {
        let url = socketURL
        let request = URLRequest(url: url)
        let authPayload = ["authToken": UserDataProvider().token]
        return WebSocketTransport(request: request, connectingPayload: authPayload)
    }()
    
    
    private(set) lazy var client = ApolloClient(networkTransport: webSocketTransport, store: store)
    
    func getMessage() -> Observable<GetMessageSubscription.Data> {
        return Observable.create { [weak self] observer in
            let cancellable = self?.client.subscribe(
                subscription: GetMessageSubscription(),
                resultHandler: { [weak self] result in
                    switch result {
                    case let .success(gqlResult):
                        if let data = gqlResult.data {
                            observer.onNext(data)
                        }
                    case .failure:
                        self?.reconnect()
                    }
                }
            )
            return Disposables.create {
                cancellable?.cancel()
            }
        }
    }
    
    func reconnect() {
        if !webSocketTransport.isConnected() {
            webSocketTransport.resumeWebSocketConnection()
        }
    }
}
