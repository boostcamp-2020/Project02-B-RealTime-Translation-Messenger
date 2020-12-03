//
//  APIConfiguration.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/02.
//

import Foundation

protocol APIConfiguration {
    var method: HTTPMethod { get }
    var path: String { get }
    var body: Data? { get }
}

enum HTTPMethod: CustomStringConvertible {
    case get
    case post
    case patch
    case delete
    
    var description: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .patch: return "PATCH"
        case .delete: return "DELETE"
        }
    }
}

enum HTTPHeader: CustomStringConvertible {
    case authentication
    case contentType
    case acceptType
    
    var description: String {
        switch self {
        case .authentication: return "Authorization"
        case .contentType: return "Accept-Encoding"
        case .acceptType: return "Content-Type"
        }
    }
}

enum ContentType: CustomStringConvertible {
    case json
    case formEncode
    
    var description: String {
        switch self {
        case .formEncode: return "Application/json"
        case .json: return "application/x-www-form-urlencoded"
        }
    }
}
