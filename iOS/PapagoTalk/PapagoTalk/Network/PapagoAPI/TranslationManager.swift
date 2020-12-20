//
//  TranslationManager.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/03.
//

import Foundation
import RxSwift

final class TranslationManager {
   
    private let service: NetworkManager
    
    init(service: NetworkManager = NetworkManager()) {
        self.service = service
    }
    
    func requestTranslation(request: TranslationRequest) -> Maybe<String> {
        let body = request.encoded()
        let apiRequest = TranslationEndPoint(body: body)
        
        return Maybe.create { [weak self] observer in
            self?.service.request(request: apiRequest) { result in
                switch result {
                case .success(let data):
                    guard let data: TranslationResponse = try? data.decoded() else {
                        observer(.error(NetworkError.invalidData(message: "Decoding Fail")))
                        return
                    }
                    observer(.success(data.message.result.translatedText))
                case .failure(let error):
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
