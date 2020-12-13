//
//  SettingViewReactor.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/12.
//

import Foundation
import ReactorKit

final class SettingViewReactor: Reactor {
    
    enum Action {
        case sizeSegmentedControlChanged(Int)
        case translationSettingSwitchChanged(Bool)
    }
    
    enum Mutation {
        case displayMicButton(MicButtonSize)
        case applyTranslationSetting(Bool)
    }
    
    struct State {
        var microphoneButtonState: MicButtonSize
        var translationSetting: Bool
    }
    
    private var userData: UserDataProviding
    
    let initialState: State
    
    init(userData: UserDataProviding) {
        self.userData = userData
        initialState = State(microphoneButtonState: userData.micButtonSize,
                             translationSetting: userData.sameLanguageTranslation)
    }
    

}
