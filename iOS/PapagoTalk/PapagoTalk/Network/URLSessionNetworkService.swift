//
//  URLSessionNetworkService.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/02.
//

import Foundation

protocol NetworkServiceProvider {
    func request(apiConfiguration: APIConfiguration, handler: @escaping (Result<Data, NetworkError>) -> Void)
}

final class URLSessionNetworkService {
    
    private let session: URLSession

    
    init(with urlSession: URLSession = .init(configuration: .default)) {
        session = urlSession
    }
    
    func request(request: TranslationRequest, handler: @escaping (Result<Data, NetworkError>) -> Void) {
        let urlRequest = configureURLRequest(request: request)
        
        session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                handler(.failure(.requestFailure(message: error.localizedDescription)))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                handler(.failure(.invalidResponse(message: "")))
                return
            }

            switch response.statusCode {
            case 100...199: // Informational
                handler(.failure(.informational(message: "\(response.statusCode)")))
                return
            case 200...299: // Success
                guard let data = data else {
                    print("no data")
                    handler(.failure(.invalidData(message: "data nil")))
                    return
                }
                handler(.success(data))
                return
            case 300...399: // Redirection
                handler(.failure(.redirection(message: "\(response.statusCode)")))
                return
            case 400...499: // Client Error
                handler(.failure(.clientError(message: "\(response.statusCode)")))
                return
            case 500...599: // Server Error
                handler(.failure(.serverError(message: "\(response.statusCode)")))
                return
            default:
                handler(.failure(.serverError(message: "\(response.statusCode)")))
                return
            }
        }.resume()
    }
    
    private func configureURLRequest(request: TranslationRequest) -> URLRequest {
        var urlRequest = URLRequest(url: APIEndPoint.papagoAPI)
        urlRequest.httpMethod = HTTPMethod.post.description
        urlRequest.setValue("\(ContentType.formEncode)", forHTTPHeaderField: "\(HTTPHeader.acceptType)")
        urlRequest.setValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        urlRequest.setValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        urlRequest.httpBody = request.encoded()
        return urlRequest
    }
}
