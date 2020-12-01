//
//  NetworkService.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/25.
//

import Foundation
import Apollo
import RxSwift

protocol NetworkServiceProviding {
    func sendMessage(text: String,
                     source: String,
                     userId: Int,
                     roomId: Int) -> Maybe<SendMessageMutation.Data>
    func getMessage(roomId: Int) -> Observable<GetMessageSubscription.Data>
    func enterRoom(user: User,
                   code: String) -> Maybe<JoinChatResponse>
    func createRoom(user: User) -> Maybe<CreateRoomResponse>
}

class NetworkService: NetworkServiceProviding {
    
    let store = ApolloStore()
    var socketURL = try? APIEndPoint.socketURL.asURL()
    var requestUR = try? APIEndPoint.requestURL.asURL()
    
    private lazy var webSocketTransport: WebSocketTransport = {
        let url = URL(string: APIEndPoint.socketURL)!
        let request = URLRequest(url: url)
        return WebSocketTransport(request: request)
    }()
    
    private lazy var normalTransport: RequestChainNetworkTransport = {
        let url = URL(string: APIEndPoint.requestURL)!
        return RequestChainNetworkTransport(interceptorProvider: LegacyInterceptorProvider(store: store), endpointURL: url)
    }()
    
    private lazy var splitNetworkTransport = SplitNetworkTransport(
        uploadingNetworkTransport: self.normalTransport,
        webSocketNetworkTransport: self.webSocketTransport
    )
    
    private(set) lazy var client = ApolloClient(networkTransport: self.splitNetworkTransport, store: store)

    func sendMessage(text: String,
                     source: String,
                     userId: Int,
                     roomId: Int) -> Maybe<SendMessageMutation.Data> {
        
        return Maybe.create { [weak self] observer in
            let cancellable = self?.client.perform(
                mutation: SendMessageMutation(text: text, source: source, userId: userId, roomId: roomId),
                resultHandler: { result in
                    switch result {
                    case let .success(gqlResult):
                        if let errors = gqlResult.errors {
                            observer(.error(errors.first!))
                        } else if let data = gqlResult.data {
                            observer(.success(data))
                        } else {
                            observer(.completed)
                        }
                        
                    case let .failure(error):
                        observer(.error(error))
                    }
                }
            )
            return Disposables.create {
                cancellable?.cancel()
            }
        }
    }
    
    func getMessage(roomId: Int) -> Observable<GetMessageSubscription.Data> {
        return Observable.create { [weak self] observer in
            let cancellable = self?.client.subscribe(
                subscription: GetMessageSubscription(roomId: roomId),
                resultHandler: { result in
                    switch result {
                    case let .success(gqlResult):
                      if let errors = gqlResult.errors {
                          observer.onError(errors.first!)
                      } else if let data = gqlResult.data {
                        observer.onNext(data)
                      }

                    case let .failure(error):
                      observer.onError(error)
                    }
                }
            )
            return Disposables.create {
                cancellable?.cancel()
            }
        }
    }
    
    func enterRoom(user: User,
                   code: String) -> Maybe<JoinChatResponse> {
        
        return Maybe.create { [weak self] observer in
            let cancellable = self?.client.perform(
                mutation: EnterRoomMutation(nickName: user.nickName, avatar: user.image, language: user.language.code, code: code),
                resultHandler: { result in
                    switch result {
                    case let .success(gqlResult):
                        if gqlResult.errors != nil {
                            observer(.error(JoinChatError.cannotFindRoom))
                        } else if let data = gqlResult.data {
                            let response = JoinChatResponse(userId: data.enterRoom.userId, roomId: data.enterRoom.roomId)
                            observer(.success(response))
                        } else {
                            observer(.completed)
                        }
                    case .failure:
                        observer(.error(JoinChatError.networkError))
                    }
                }
            )
            return Disposables.create {
                cancellable?.cancel()
            }
        }
    }
    
    func createRoom(user: User) -> Maybe<CreateRoomResponse> {
        return Maybe.create { [weak self] observer in
            let cancellable = self?.client.perform(
                mutation: CreateRoomMutation(nickname: user.nickName, avatar: user.image, lang: user.language.code),
                resultHandler: { result in
                    switch result {
                    case let .success(gqlResult):
                        if gqlResult.errors != nil {
                            observer(.error(JoinChatError.cannotFindRoom))
                        } else if let data = gqlResult.data {
                            observer(.success(data.createRoom))
                        } else {
                            observer(.completed)
                        }
                    case .failure:
                        observer(.error(JoinChatError.networkError))
                    }
                }
            )
            return Disposables.create {
                cancellable?.cancel()
            }
        }
    }
}

enum NetworkError: Error {
    case invalidURL
}

extension String {
  func asURL() throws -> URL {
    guard let url = URL(string: self) else { throw NetworkError.invalidURL }
    return url
  }
}
