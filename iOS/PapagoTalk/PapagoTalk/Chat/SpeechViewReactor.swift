//
//  SpeechViewReactor.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/02.
//

import Foundation
import ReactorKit

final class SpeechViewReactor: Reactor {
    
    enum Action {
        case microphoneButtonTapped
        case speechTextChanged(String)
        case originTextChanged(String)
    }
    
    enum Mutation {
        case setSpeechRecognition(String)
        case setOriginText(String)
        case setTranslatedText(String)
    }
    
    struct State {
        var speechRecognizedText: String
        var originText: String
        var translatedText: String
    }
    
    private let speechManager = SpeechManager()
    private let translationManager = PapagoAPIManager()
    private let userData = UserDataProvider()
    let initialState: State
    var disposeBag = DisposeBag()
    
    init() {
        initialState = State(speechRecognizedText: "", originText: "", translatedText: "...")
        bind()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .microphoneButtonTapped:
            speechManager.speechToText()
            return .just(Mutation.setSpeechRecognition(""))
        case .speechTextChanged(let output):
            return .just(Mutation.setSpeechRecognition(output))
        case .originTextChanged(let input):
            return .concat([
                translate(text: input),
                .just(Mutation.setOriginText(input))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setSpeechRecognition(let output):
            state.speechRecognizedText = output
        case .setTranslatedText(let output):
            state.translatedText = output
        case .setOriginText(let output):
            state.originText = output
        }
        return state
    }
    
    private func bind() {
        speechManager.recognizedSpeech
            .map { Action.speechTextChanged($0) }
            .bind(to: action)
            .disposed(by: disposeBag)
    }
    
    private func translate(text: String) -> Observable<Mutation> {
        let oppositeLanguage: Language = userData.language == .korean ? .english : .korean
        return translationManager
            .requestTranslation(request: TranslationRequest(source: userData.language.code,
                                                            target: oppositeLanguage.code,
                                                            text: text))
            .asObservable()
            .map { Mutation.setTranslatedText($0) }
    }
}
