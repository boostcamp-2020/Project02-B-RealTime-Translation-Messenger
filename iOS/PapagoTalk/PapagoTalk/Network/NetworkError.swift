//
//  NetworkError.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/02.
//

import Foundation

enum NetworkError: Error {
    
    // MARK: Request Error
    
    case invalidURL
    case requestFailure(message: String)

    // MARK: Response Error
    
    case invalidResponse(message: String)
    case invalidData(message: String)
    
    // MARK: Status Code
    
    case informational(message: String)
    case redirection(message: String)
    case clientError(message: String)
    case serverError(message: String)

    // MARK: Token

    case tokenExpiration(message: String)
}
