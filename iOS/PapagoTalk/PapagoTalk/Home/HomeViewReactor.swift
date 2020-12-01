//
//  HomeViewReactor.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/11/24.
//

import Foundation
import ReactorKit

final class HomeViewReactor: Reactor {
    
    enum Action {
        case profileImageTapped
        case nickNameChanged(String)
        case languageSelected(Language)
        case makeChatRoomButtonTapped
    }
    
    enum Mutation {
        case setImage(String)
        case setNickName(String)
        case shakeNickNameTextField(Bool)
        case setLanguage(Language)
        case createRoom(CreateRoomResponse)
        case alertError(HomeError)
        case clearErrorMessage
    }
    
    struct State {
        var profileImageURL: String
        var nickName: String
        var needShake: Bool
        var language: Language
        var createRoomResponse: CreateRoomResponse?
        var errorMessage: String?
        
        var isNickNameValid: Bool {
            (2...12) ~= nickName.count
        }
    }
    
    private let defaultImageFactory: ImageFactoryProviding
    
    let initialState: State
    let user = HomeViewController.user
    let networkService = NetworkService()
    
    init(imageFactory: ImageFactoryProviding = ImageFactory()) {
        defaultImageFactory = imageFactory
        
        initialState = State(profileImageURL: user.image,
                             nickName: user.nickName,
                             needShake: false,
                             language: user.language)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .nickNameChanged(let nickName):
            return blockNickNameMaxLength(input: nickName)
        case .profileImageTapped:
            return configureRandomImage()
        case .languageSelected(let language):
            return .just(Mutation.setLanguage(language))
        case .makeChatRoomButtonTapped:
            return currentState.isNickNameValid ? requestCreateRoom() : .concat([.just(.alertError(.invalidNickName)), .just(.clearErrorMessage)])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setNickName(let nickName):
            state.nickName = nickName
        case .shakeNickNameTextField(let needShake):
            state.needShake = needShake
        case .setImage(let imageURL):
            state.profileImageURL = imageURL
        case .setLanguage(let language):
            state.language = language
        case .createRoom(let response):
            state.createRoomResponse = response
        case .alertError(let error):
            state.errorMessage = error.message
        case .clearErrorMessage:
            state.errorMessage = nil
        }
        return state
    }
    
    private func blockNickNameMaxLength(input nickName: String) -> Observable<Mutation> {
        let maxValue = Constant.maxNickNameLength
        let needShake = nickName.count > maxValue
        
        guard needShake else {
            return Observable.just(Mutation.setNickName(String(nickName.prefix(maxValue))))
        }
        return Observable.concat([
            Observable.just(Mutation.shakeNickNameTextField(needShake)),
            Observable.just(Mutation.setNickName(String(nickName.prefix(maxValue)))),
            Observable.just(Mutation.shakeNickNameTextField(!needShake))
        ])
    }
    
    private func configureRandomImage() -> Observable<Mutation> {
        return Observable.just(Mutation.setImage(defaultImageFactory.randomImageURL()))
    }
    
    private func requestCreateRoom() -> Observable<Mutation> {
        return networkService.createRoom(user: user)
            .asObservable()
            .map { Mutation.createRoom($0) }
            .catchError { _ in
                .concat([ .just(.alertError(.networkError)),
                          .just(.clearErrorMessage)])
            }
    }
}
