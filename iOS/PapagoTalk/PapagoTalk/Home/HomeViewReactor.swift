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
    }
    
    enum Mutation {
        case setNickName(String)
        case shakeNickNameTextField(Bool)
        case setImage(String)
        
    }
    
    struct State {
        var nickName: String
        var profileImageURL: String
        var isInvalidNickNameLength: Bool
    }
    
    var initialState: State
    var defaultImageFactory: ImageFactory
    
    init(imageFactory: ImageFactory = DefaultImageFactory()) {
        defaultImageFactory = imageFactory
        initialState = State(nickName: "",
                                  profileImageURL: defaultImageFactory.randomImageURL(),
                                  isInvalidNickNameLength: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .nickNameChanged(let nickName):
            return blockNickNameMaxLength(input: nickName)
        case .profileImageTapped:
            return configureRandomImage()
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
        }
        return state
    }
    
    private func blockNickNameMaxLength(input nickName: String) -> Observable<Mutation> {
        let needShake = nickName.count > 12
        
        guard needShake else {
            return Observable.just(Mutation.setNickName(String(nickName.prefix(12))))
        }
        return Observable.concat([
            Observable.just(Mutation.shakeNickNameTextField(needShake)),
            Observable.just(Mutation.setNickName(String(nickName.prefix(12)))),
            Observable.just(Mutation.shakeNickNameTextField(!needShake))
        ])
    }
    
    private func configureRandomImage() -> Observable<Mutation> {
        return Observable.just(Mutation.setImage(defaultImageFactory.randomImageURL()))
    }
}
