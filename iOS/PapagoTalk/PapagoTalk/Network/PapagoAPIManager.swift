//
//  PapagoAPIManager.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/03.
//

import Foundation
import RxSwift

final class PapagoAPIManager {
   
    private let service: URLSessionNetworkServiceProviding
    
    init(service: URLSessionNetworkServiceProviding = URLSessionNetworkService()) {
        self.service = service
    }
    
    func requestTranslation(request: TranslationRequest) -> Maybe<String> {
        let body = request.encoded()
        let apiRequest = PapagoAPIRequest(body: body)
        
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

struct PapagoAPIRequest: HTTPRequest {
    var url: URL = APIEndPoint.papagoAPI
    var httpMethod: HTTPMethod = .post
    var headers: [String: String] = [
        "Content-Type": "Application/json",
        "X-Naver-Client-Id": APIEndPoint.clientID,
        "X-Naver-Client-Secret": APIEndPoint.clientSecret
    ]
    var body: Data?
    
    init(body: Data?) {
        self.body = body
    }
}
