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
        case nickNameChanged(String)
        case profileImageTapped
        case languageSelected(Language)
    }
    
    enum Mutation {
        case setNickName(String)
        case shakeNickNameTextField(Bool)
        case setImage(String)
        case setLanguage(Language)
    }
    
    struct State {
        var nickName: String
        var profileImageURL: String
        var language: String
        var isInvalidNickNameLength: Bool
    }
    
    private let defaultImageFactory: ImageFactory
    
    let initialState: State
    
    init(imageFactory: ImageFactory = DefaultImageFactory()) {
        defaultImageFactory = imageFactory
        initialState = State(nickName: "",
                             profileImageURL: defaultImageFactory.randomImageURL(),
                             language: Locale.currentLanguage.localizedText,
                             isInvalidNickNameLength: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .nickNameChanged(let nickName):
            return blockNickNameMaxLength(input: nickName)
        case .profileImageTapped:
            return configureRandomImage()
        case .languageSelected(let language):
            return Observable.just(Mutation.setLanguage(language))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setNickName(let nickName):
            state.nickName = nickName
        case .shakeNickNameTextField(let needShake):
            state.isInvalidNickNameLength = needShake
        case .setImage(let imageURL):
            state.profileImageURL = imageURL
        case .setLanguage(let language):
            state.language = language.localizedText
        }
        return state
    }
    
    private func blockNickNameMaxLength(input nickName: String) -> Observable<Mutation> {
        let isInvalidLength = nickName.count > Constant.maxNickNameLength
        
        guard isInvalidLength else {
            return Observable.just(Mutation.setNickName(String(nickName.prefix(12))))
        }
        return Observable.concat([
            Observable.just(Mutation.shakeNickNameTextField(isInvalidLength)),
            Observable.just(Mutation.setNickName(String(nickName.prefix(12)))),
            Observable.just(Mutation.shakeNickNameTextField(!isInvalidLength))
        ])
    }
    
    private func configureRandomImage() -> Observable<Mutation> {
        return Observable.just(Mutation.setImage(defaultImageFactory.randomImageURL()))
    }
}
