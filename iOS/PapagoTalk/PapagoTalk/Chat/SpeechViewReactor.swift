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
        case speechTextChanged
    }
    
    enum Mutation {
        case setSpeechRecognition
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
        speechManager.ob
            .do {
                print($0)
            }
            .map { _ in Action.speechTextChanged }
            .bind(to: action)
            .disposed(by: disposeBag)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .microphoneButtonTapped:
            speechManager.speechToText()
            return Observable.just(Mutation.setSpeechRecognition)
        case .speechTextChanged:
            return Observable.just(Mutation.setSpeechRecognition)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setSpeechRecognition:
            state.speechRecognizedText = ""
        case .setTranslation:
            state.translatedText = ""
        }
        return state
    }
    
//    private func search(query: String?, page: Int) -> Observable<String> {
//        let emptyResult: ([String], Int?) = ([], nil)
//        guard let url = self.url(for: query, page: page) else { return .just(emptyResult) }
//        return URLSession.shared.rx.json(url: url)
//          .map { json -> ([String], Int?) in
//            guard let dict = json as? [String: Any] else { return emptyResult }
//            guard let items = dict["items"] as? [[String: Any]] else { return emptyResult }
//            let repos = items.compactMap { $0["full_name"] as? String }
//            let nextPage = repos.isEmpty ? nil : page + 1
//            return (repos, nextPage)
//          }
//          .do(onError: { error in
//            if case let .some(.httpRequestFailed(response, _)) = error as? RxCocoaURLError, response.statusCode == 403 {
//              print("⚠️ GitHub API rate limit exceeded. Wait for 60 seconds and try again.")
//            }
//          })
//          .catchErrorJustReturn(emptyResult)
//      }
//    }
}

//extension SpeechViewReactor.Action {
//  static func isUpdateSpeech(_ action: SpeechViewReactor.Action) -> Bool {
//    if case .microphoneButtonTapped = action {
//      return true
//    } else {
//      return false
//    }
//  }
