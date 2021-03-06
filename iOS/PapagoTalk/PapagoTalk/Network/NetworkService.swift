//
//  NetworkService.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/25.
//

import Foundation
import Apollo
import RxSwift

class NetworkService: NetworkServiceProviding {
    
    let store = ApolloStore()
    let urlClient = URLSessionClient()
    var requestURL = APIEndPoint.requestURL
    
    private lazy var transport: RequestChainNetworkTransport = {
        let url = requestURL
        return RequestChainNetworkTransport(interceptorProvider: NetworkInterceptorProvider(store: store, client: urlClient), endpointURL: url)
    }()
    
    private(set) lazy var client = ApolloClient(networkTransport: transport, store: store)
    
    func sendMessage(text: String) -> Maybe<SendMessageMutation.Data> {
        return Maybe.create { [weak self] observer in
            let cancellable = self?.client.perform(
                mutation: SendMessageMutation(text: text),
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
    
    func getMissingMessage(timeStamp: String) -> Maybe<GetMessageByTimeQuery.Data> {
        return Maybe.create { [weak self] observer in
            let cancellable = self?.client.fetch(
                query: GetMessageByTimeQuery(timeStamp: timeStamp),
                cachePolicy: .fetchIgnoringCacheCompletely,
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
    
    func enterRoom(user: User, code: String) -> Maybe<JoinChatResponse> {
        return Maybe.create { [weak self] observer in
            let cancellable = self?.client.perform(
                mutation: EnterRoomMutation(nickName: user.nickName, avatar: user.image, language: user.language.code, code: code),
                resultHandler: { result in
                    switch result {
                    case let .success(gqlResult):
                        if gqlResult.errors != nil {
                            observer(.error(JoinChatError.cannotFindRoom))
                        } else if let data = gqlResult.data {
                            let response = JoinChatResponse(userId: data.enterRoom.userId, roomId: data.enterRoom.roomId, token: data.enterRoom.token)
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
    
    func getUserList(of roomID: Int) -> Maybe<FindRoomByIdQuery.Data> {
        return Maybe.create { [weak self] observer in
            let cancellable = self?.client.fetch(
                query: FindRoomByIdQuery(roomID: roomID),
                cachePolicy: .fetchIgnoringCacheCompletely,
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
  
    func translate(text: String) -> Maybe<String> {
        return Maybe.create { [weak self] observer in
            let cancellable = self?.client.perform(
                mutation: TranslationMutation(text: text),
                resultHandler: { result in
                    switch result {
                    case let .success(gqlResult):
                        if let error = gqlResult.errors?.first {
                            observer(.error(error))
                        } else if let data = gqlResult.data {
                            observer(.success(data.translation.translatedText))
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
  
    func leaveRoom() {
        sendSystemMessage(type: "out")
        client.perform(mutation: LeaveRoomMutation())
    }
    
    func sendSystemMessage(type: String) {
        client.perform(mutation: SendSystemMessageMutation(type: type))
    }
}
