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
    }
    
    enum Mutation {
        case setSpeechRecognition(String)
        case setTranslation
    }
    
    struct State {
        var speechRecognizedText: String
        var translatedText: String
    }
    
    private let speechManager = SpeechManager()
    private let translationManager = PapagoAPIManager()
    let initialState: State
    var disposeBag = DisposeBag()
    
    init() {
        initialState = State(speechRecognizedText: "", translatedText: "...")
        bind()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .microphoneButtonTapped:
            speechManager.speechToText()
            return Observable.just(Mutation.setSpeechRecognition(""))
        case .speechTextChanged(let output):
            return Observable.just(Mutation.setSpeechRecognition(output))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setSpeechRecognition(let output):
            state.speechRecognizedText = output
        case .setTranslation:
            state.translatedText = ""
        }
        return state
    }
    
    private func bind() {
        speechManager.recognizedSpeech
            .map { Action.speechTextChanged($0) }
            .bind(to: action)
            .disposed(by: disposeBag)
    }
}
