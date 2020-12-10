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
        case joinChatRoomButtonTapped
    }
    
    enum Mutation {
        case setImage(String)
        case setNickName(String)
        case shakeNickNameTextField(Bool)
        case setLanguage(Language)
        case createRoom(CreateRoomResponse)
        case joinRoom(Bool)
        case alertError(HomeError)
    }
    
    struct State {
        var profileImageURL: String
        var nickName: String
        var needShake: RevisionedData<Bool>
        var language: Language
        var createRoomResponse: CreateRoomResponse?
        var joinRoom: RevisionedData<Bool>
        var errorMessage: RevisionedData<String?>
        
        var isNickNameValid: Bool {
            (Constant.minNickNameLength...Constant.maxNickNameLength) ~= nickName.count
        }
    }
    
    private let networkService: NetworkServiceProviding
    private var userData: UserDataProviding
    private let defaultImageFactory: ImageFactoryProviding
    
    let initialState: State
    
    init(networkService: NetworkServiceProviding,
         userData: UserDataProviding,
         imageFactory: ImageFactoryProviding = ImageFactory()) {
        
        self.networkService = networkService
        self.userData = userData
        defaultImageFactory = imageFactory
        initialState = State(profileImageURL: userData.image,
                             nickName: userData.nickName,
                             needShake: RevisionedData(data: false),
                             language: userData.language,
                             joinRoom: RevisionedData(data: false),
                             errorMessage: RevisionedData(data: nil))
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
            return currentState.isNickNameValid ?
                requestCreateRoom() : .just(.alertError(.invalidNickName))
        case .joinChatRoomButtonTapped:
            return currentState.isNickNameValid ?
                .just(.joinRoom(true)) : .just(.alertError(.invalidNickName))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setNickName(let nickName):
            state.nickName = nickName
            userData.nickName = nickName
        case .shakeNickNameTextField(let needShake):
            state.needShake = state.needShake.update(needShake)
        case .setImage(let imageURL):
            state.profileImageURL = imageURL
            userData.image = imageURL
        case .setLanguage(let language):
            state.language = language
            userData.language = language 
        case .createRoom(let response):
            state.createRoomResponse = response
        case .joinRoom(let isAvaliable):
            state.joinRoom = state.joinRoom.update(isAvaliable)
        case .alertError(let error):
            state.errorMessage = state.errorMessage.update(error.message)
        }
        return state
    }
    
    private func blockNickNameMaxLength(input nickName: String) -> Observable<Mutation> {
        let maxLength = Constant.maxNickNameLength
        let needShake = nickName.count > maxLength

        return .concat([
            .just(Mutation.setNickName(String(nickName.prefix(maxLength)))),
            .just(Mutation.shakeNickNameTextField(needShake))
        ])
    }
    
    private func configureRandomImage() -> Observable<Mutation> {
        return .just(Mutation.setImage(defaultImageFactory.randomImageURL()))
    }
    
    private func requestCreateRoom() -> Observable<Mutation> {
        networkService.leaveRoom()
        return networkService.createRoom(user: userData.user)
            .asObservable()
            .do(onNext: { [weak self] in 
                self?.userData.id = $0.userId
                self?.userData.token = $0.token
            })
            .map { Mutation.createRoom($0) }
            .catchError { _ in
                .just(.alertError(.networkError))
            }
    }
}
