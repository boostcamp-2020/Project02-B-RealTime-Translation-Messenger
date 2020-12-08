//
//  SpeechViewReactor.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/02.
//

import Foundation
import ReactorKit
import RxCocoa

final class SpeechViewReactor: Reactor {
    
    enum Action {
        case microphoneButtonTapped
        case speechTextChanged(String)
        case originTextChanged(String)
        case translatedTextChaged(String)
        case speechRecognitionAvailabiltyChanged(Bool)
        case originSendButtonTapped
        case translatedSendButtonTapped
    }
    
    enum Mutation {
        case setSpeechRecognition(String)
        case setOriginText(String)
        case setTranslatedText(String)
        case setIsMicrophoneButtonEnable(Bool)
        case sendMessage
    }
    
    struct State {
        var speechRecognizedText: String
        var originText: String
        var translatedText: String
        var isMicrophoneButtonEnable: Bool
        var messageDidSend: Bool = false
    }
    
    private let speechManager: SpeechServiceProviding
    private let translationManager: PapagoAPIServiceProviding
    private let userData: UserDataProviding
    private let networkService: NetworkServiceProviding
    private let roomID: Int
    let initialState: State
    var disposeBag = DisposeBag()
    
    init(networkService: NetworkServiceProviding,
         userData: UserDataProviding,
         translationManager: PapagoAPIServiceProviding,
         speechManager: SpeechServiceProviding,
         roomID: Int) {
        
        self.networkService = networkService
        self.userData = userData
        self.translationManager = translationManager
        self.speechManager = speechManager
        self.roomID = roomID
        
        initialState = State(speechRecognizedText: "", originText: "", translatedText: "", isMicrophoneButtonEnable: true)
        bind()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .microphoneButtonTapped:
            speechManager.speechToText()
            return .just(.setSpeechRecognition(""))
        case .speechTextChanged(let output):
            return .just(.setSpeechRecognition(output))
        case .originTextChanged(let input):
            return .concat([
                .just(.setOriginText(input)),
                translate(text: input)
            ])
        case .translatedTextChaged(let input):
            return .just(.setTranslatedText(input))
        case .speechRecognitionAvailabiltyChanged(let isAvailable):
            return .just(.setIsMicrophoneButtonEnable(isAvailable))
        case .originSendButtonTapped:
            return requestSendMessage(message: currentState.originText)
        case .translatedSendButtonTapped:
            return requestSendMessage(message: currentState.translatedText)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setSpeechRecognition(let output):
            state.speechRecognizedText = output
        case .setOriginText(let output):
            state.originText = output
        case .setTranslatedText(let output):
            state.translatedText = output
        case .setIsMicrophoneButtonEnable(let isEnable):
            state.isMicrophoneButtonEnable = isEnable
        case .sendMessage:
            state.messageDidSend.toggle()
        }
        return state
    }
    
    private func bind() {
        speechManager.recognizedSpeech
            .map { Action.speechTextChanged($0) }
            .bind(to: action)
            .disposed(by: disposeBag)
        
        speechManager.isAvailable
            .map { Action.speechRecognitionAvailabiltyChanged($0) }
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
    
    private func requestSendMessage(message: String) -> Observable<Mutation> {
        return networkService.sendMessage(text: message,
                                          source: userData.language.code,
                                          userId: userData.id,
                                          roomId: roomID)
            .asObservable()
            .map { _ in Mutation.sendMessage }
    }
}
