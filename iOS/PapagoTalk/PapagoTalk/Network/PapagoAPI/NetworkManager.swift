//
//  NetworkManager.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/02.
//

import Foundation

/// URLSession Network Service
final class NetworkManager {
    
    private let session: URLSession

    init(with urlSession: URLSession = .init(configuration: .default)) {
        session = urlSession
    }
    
    func request(request: APIConfiguration, handler: @escaping (Result<Data, NetworkError>) -> Void) {
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
    
    private func configureURLRequest(request: APIConfiguration) -> URLRequest {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.httpMethod.description
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body
        return urlRequest
    }
}
